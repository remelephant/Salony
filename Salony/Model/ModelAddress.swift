//
//  ModelAddress.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

class ModelAddress: Decodable {
    var id: Int?
    var label: String?
    var preview: String?
    var province: String?
    var provinceID: String?
    var area: String?
    var areaID: Int?
    var block: String?
    var street: String?
    var avenue: String?
    var building: String?
    var latitude: String?
    var longitude: String?
    var locationInstructions: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case preview
        case province
        case provinceID = "province_id"
        case area
        case areaID = "area_id"
        case block
        case street
        case avenue
        case building
        case latitude = "lat"
        case longitude = "lng"
        case locationInstructions = "location_instructions"
        
    }
}
