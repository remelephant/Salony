//
//  MapViewController.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, UIActivityPresenter {
    
    //MARK: - Properties
    
    // UIActivityPresenter
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var whiteView: UIView = UIView()
    
    // IBOutlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var centerPoint: UIView!
    
    let locationManager = LocationManager()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Configure UI elements
        configureNavigationController()
        configureLocationButton()
        configureMapView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.mapVCToAddressVC {
            if let viewController = segue.destination as? AddressViewController {
                // sending current center point coordinate to "AddressViewController"
                if let coordinate = sender as? CLLocationCoordinate2D {
                    viewController.coordinate = coordinate
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func skipButtonAction(_ sender: Any) {
        performSegue(withIdentifier: Constants.Segues.mapVCToAddressVC, sender: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let coordinate = mapView.projection.coordinate(for: centerPoint.center)
        performSegue(withIdentifier: Constants.Segues.mapVCToAddressVC, sender: coordinate)
    }
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        locationManager.findCurrentLocation()
    }
}

// MARK: - Supporting functions
private extension MapViewController {
    
    func configureNavigationController() {
        // changing Navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.62, green:0.12, blue:0.38, alpha:1.0)
        self.navigationItem.title = ""
    }
    
    func configureMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 29.364813, longitude: 47.982395, zoom: 17)
        
        mapView.camera = camera
        mapView.padding = UIEdgeInsets(top: 0, left: 5, bottom: 55, right: 0)
    }
    
    private func configureLocationButton() {
        /// adding shadow to "locationButton"
        locationButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.34).cgColor
        locationButton.layer.shadowOpacity = 1.0
        locationButton.layer.shadowRadius = 3
        locationButton.layer.masksToBounds = false
    }
}

extension MapViewController: LocationManagerDelegate {
    func locationAccessDenied() {
        showAlertWithoutAction(message: "Enable Location services from settings")
    }
    
    func locationDidFound(placemark: CLPlacemark?) {
        if let placemark = placemark {
            let coordinate = placemark.location?.coordinate
            
            CATransaction.begin()
            CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
            
            // animate camera to the users current coordinates
            let camera = GMSCameraPosition.camera(withTarget: coordinate!, zoom: 17)
            mapView!.animate(to: camera)
            CATransaction.commit()
        }
    }
}
