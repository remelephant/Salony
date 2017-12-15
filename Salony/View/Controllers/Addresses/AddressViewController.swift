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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddressVC_AddressTVC" {
            if let viewController = segue.destination as? AddressTableViewController {
                viewController.coordinate = coordinate
            }
        }
    }
}

// MARK: - Supporting functions
private extension AddressViewController {
    
    private func configureMapView() {
        if let coordinate = coordinate {
            let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
            mapView.camera = camera
            mapView.isUserInteractionEnabled = false
        } else {
            // hide "locationMark" in if user is skipped location "pinning"
            locationMark.isHidden = true
        }
    }
}
