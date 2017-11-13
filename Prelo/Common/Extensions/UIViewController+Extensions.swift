//
//  UIViewController+Extensions.swift
//  Prelo
//
//  Created by Fachri Work on 11/13/17.
//  Copyright © 2017 Decadev. All rights reserved.
//


import UIKit

extension UIViewController {
    typealias AlertActionHandler = (() -> Void)
    
    func showAlert(title: String?, message: String, actions: ((UIAlertAction) -> Void)? = nil) {
        
        var localizedTitle: String? {
            if let title = title {
                return NSLocalizedString(title, comment: "")
            } else {
                return nil
            }
        }
        
        let localizedMessage = NSLocalizedString(message, comment: "")
        let localizedOk = NSLocalizedString("Ok", comment: "")
        
        let alert = UIAlertController(title: localizedTitle, message: localizedMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: localizedOk, style: .default, handler: {  actions }())
        alert.addAction(action)
        
        self.showDetailViewController(alert, sender: nil)
    }
}
