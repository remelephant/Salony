//
//  RequestParameterBuilder.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import GoogleMaps


/// This class is for handling process of creation http parameters or bodies for all requests
struct RequestParameterBuilder {
    static func addressParameter(coordinate: CLLocationCoordinate2D) -> [String: String] {
        return ["lat": String(format: "%.6f", coordinate.latitude), "lng": String(format: "%.6f", coordinate.longitude)]
        
        // MARK: - Remove after testing
//        return ["lat": "29.364813", "lng": "47.982395"]
    }
}
