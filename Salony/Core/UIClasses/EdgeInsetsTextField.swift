//
//  EdgeInsetsTextField.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/15/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

class EdgeInsetsTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
