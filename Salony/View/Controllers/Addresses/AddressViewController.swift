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
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        configureMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

// MARK: - Supporting functions
extension AddressViewController {
    
    private func configureMapView() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate!, zoom: 17)
        mapView.camera = camera
        print(coordinate)    }
}
