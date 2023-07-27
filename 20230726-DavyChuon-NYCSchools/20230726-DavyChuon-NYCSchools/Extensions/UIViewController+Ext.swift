//
//  UIViewController+Ext.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/27/23.
//

import UIKit

extension UIViewController {
    
    // Presents UIAlert in a view controller
    func presentAlert(title: String = "An error occured", message: String = "Please try again", preferredStyle: UIAlertController.Style = .alert, actionTitle: String = "OK", actionStyle: UIAlertAction.Style = .default) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
