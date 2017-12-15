//
//  DoubleExtension.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
