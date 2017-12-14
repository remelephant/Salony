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
    var province_id: String?
    var areaID: String?
    var block: String?
    var street: String?
    var avenue: String?
    var building: String?
    var latitude: String?
    var longitude: String?
    var locationInstructions: String?
    
    enum CodingKeys: String, CodingKey {
        case locationInstructions = "location_instructions"
        case province_id = "province_id"
    }
}
