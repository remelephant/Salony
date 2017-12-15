//
//  AddressViewController.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import GoogleMaps

class AddressViewController: UIViewController {
    
    //MARK: - Properties
    var coordinate: CLLocationCoordinate2D?
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationMark: UIImageView!
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        configureMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddressVC_AddressTVC" {
            if let viewController = segue.destination as? AddressTableViewController {
                viewController.delegate = self
                viewController.coordinate = coordinate
            }
        }
    }
}

// MARK: - Supporting functions
private extension AddressViewController {
    
    private func configureMapView() {
        
        mapView.isUserInteractionEnabled = false
        if let coordinate = coordinate {
            let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
            mapView.camera = camera
        } else {
            // hide "locationMark" in if user is skipped location "pinning"
            locationMark.isHidden = true
        }
    }
}

// MARK: - AddressTableViewProtocol
extension AddressViewController: AddressTableViewProtocol {
    func closeButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
