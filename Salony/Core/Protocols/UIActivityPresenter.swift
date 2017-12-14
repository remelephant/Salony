//
//  UIActivityPresenter.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation
import UIKit

/*
 for this kind of functionality it is better to use protocols instead of subclassing
 */
/// Avtivity presenter protocol
public protocol UIActivityPresenter {
    var activityIndicator: UIActivityIndicatorView { get }
    var whiteView: UIView { get }
}


public extension UIActivityPresenter where Self: UIViewController {
    
    /// loader position can be modified
    func startAnimating() {
        DispatchQueue.main.async {
            self.whiteView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.view.addSubview(self.whiteView)
            self.whiteView.frame = self.view.bounds
            self.activityIndicator.activityIndicatorViewStyle = .whiteLarge
            self.activityIndicator.color = UIColor.gray
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: (self.view.bounds.height / 2) - 70)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.whiteView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    func addAlertWithoutAction(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title ?? "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
