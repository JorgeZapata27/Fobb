//
//  UIAlertController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/7/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String, withDescription description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alertController, animated: true)
    }
    
}
