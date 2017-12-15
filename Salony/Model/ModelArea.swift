//
//  ModelArea.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

class ModelArea: Decodable {
    var name: String?
    var province: ModelProvince?
    var id: Int?
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case province
        case id
        case latitude = "lat"
        case longitude = "long"
    }
}

class ModelProvince: Decodable {
    var name: String?
    var id: Int?
}
