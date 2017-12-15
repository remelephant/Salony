//
//  AddressTableViewController.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import DropDown
import GoogleMaps

class AddressTableViewController: UITableViewController, UIActivityPresenter {
    
    //MARK: - Properties
    
    // UIActivityPresenter
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var whiteView: UIView = UIView()
    
    // IBOutlets
    @IBOutlet weak var addressNameTextField: EdgeInsetsTextField!
    @IBOutlet weak var apartmentTypeTextField: UITextField!
    @IBOutlet weak var blockTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var buildingTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var appartmentNumberTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    let server = AddressDataManager()
    var coordinate: CLLocationCoordinate2D?
    
    // MARK: - Drop Down
    let dropDown = DropDown()
    @IBOutlet weak var areaButton: UIButton!
    
    /*
     we need to call "configureDropDown()" every time
     after "dropDownDataSource" is set
     */
    var dropDownDataSource: [String] = [] {
        didSet {
            configureDropDown()
        }
    }
    
    /*
     we need to call reload tableView every time
     after "address" is set. This makes our tableview dynamic
     */
    var address: ModelAddress? {
        didSet {
            if let address = address {
                updateFieldsWithAddress(address: address)
            }
        }
    }
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        configureTextView()
        configureTextFields()
        
        // Fetch user data
        fetchData()
    }
    
    //MARK: - IBActions
    @IBAction func areaButtonPressed(_ sender: Any) {
        dropDown.show()
    }
    
}

// MARK: - UITableViewDataSource
extension AddressTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

// MARK: - Supporting Functions
private extension AddressTableViewController {
    
    func fetchData() {
        startAnimating()
        server.fetchData(coordinate: coordinate) { [weak self] (address, areas) in
            if let address = address {
                self?.address = address
            }
            
            if let areas = areas {
                self?.dropDownDataSource = areas
            }
            self?.stopAnimating()
        }
    }
    
    func configureDropDown() {
        dropDown.dataSource = dropDownDataSource
        dropDown.anchorView = areaButton
        dropDown.selectionAction = { [weak self] (index, item) in
            self?.setAreaDropDownButtonSelected(name: item)
        }
    }
    
    func setAreaDropDownButtonSelected(name: String) {
        areaButton.setTitleColor(UIColor.black, for: .normal)
        areaButton.setTitle(name, for: .normal)
    }
    
    /// Should be configured when datasource is set
    func configureTextView() {
        instructionsTextView.delegate = self
        instructionsTextView.text = "Special instructions (optional)"
        instructionsTextView.textColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func configureTextFields() {
        addressNameTextField.delegate = self
        addressNameTextField.padding = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        apartmentTypeTextField.delegate = self
        blockTextField.delegate = self
        streetTextField.delegate = self
        buildingTextField.delegate = self
        floorTextField.delegate = self
        appartmentNumberTextField.delegate = self
        mobileNumberTextField.delegate = self
        instructionsTextView.delegate = self
    }
    
    func updateFieldsWithAddress(address: ModelAddress) {
//        addressNameTextField.text = address.preview
        if let area = address.area {
            setAreaDropDownButtonSelected(name: area)
        }
//        apartmentTypeTextField.text =
        blockTextField.text = address.block
        streetTextField.text = address.street
        buildingTextField.text = address.building
//        floorTextField.text =
//        appartmentNumberTextField.text =
//        mobileNumberTextField.text =
    }
}

// MARK: - UITextViewDelegate
extension AddressTableViewController: UITextViewDelegate {
    
    // UITextView dont have placeholder by default
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.black.withAlphaComponent(0.3) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    // If after did end editing text is empty this functions create placeholder again
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Special instructions (optional)"
            textView.textColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    // close textView after enter is pressed
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension AddressTableViewController: UITextFieldDelegate {
    
    /// Called when 'return' key pressed. return NO to ignore.
    ///
    /// - Parameter textField: selected textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
