//
//  LocationManager.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationDidFound(placemark: CLPlacemark?)
    func locationAccessDenied()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    private var currentLocation: CLLocation! {
        didSet {
            obtainUserLoaction(currentLocation: currentLocation) { [weak self] (placemark) in
                self?.delegate?.locationDidFound(placemark: placemark)
            }
        }
    }
    
    /// find users locations
    func findCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                updateCurrentLocation()
            case .denied, .restricted:
                delegate?.locationAccessDenied()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updateCurrentLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            currentLocation = location
            print("Current location updated")
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func obtainUserLoaction(currentLocation: CLLocation, completion: @escaping (CLPlacemark?) -> ()) {

        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (place, error) in
                DispatchQueue.main.async {
                    guard error == nil, let address = place?[0] else {
                        completion (nil)
                        return
                    }
                    completion(address)
                }
            })
            locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            updateCurrentLocation()
            print("authorizedAlways")
        case .denied, .restricted, .notDetermined:
            print("denied")
        }
    }
}
