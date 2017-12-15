//
//  SalonyTests.swift
//  SalonyTests
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import XCTest
@testable import Salony
import GoogleMaps

class SalonyTests: XCTestCase {
    
    let parameterBuilder = RequestParameterBuilder()
    
    func testParameterBuilder() {
        let expression1 = parameterBuilder.addressParameter(coordinate: CLLocationCoordinate2D(latitude: 12.123456789, longitude: 12.1234567))
        let expression2 = ["lat": "12.123456", "lng": "12.123456"]
        
        XCTAssertEqual(expression1["lat"]?.count, expression2["lat"]?.count)
        XCTAssertEqual(String(describing: expression1["lat"]?.dropLast()), String(describing: expression2["lat"]?.dropLast()))
        
        XCTAssertEqual(String(describing: expression1["lng"]?.dropLast()), String(describing: expression2["lng"]?.dropLast()))
    }
    
}
