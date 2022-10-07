//
//  ProgressHUD.swift
//  Fobb
//
//  Created by JJ Zapata on 10/7/22.
//

import Foundation
import UIKit
import ProgressHUD

extension UIViewController {
    
    func showLoading() {
        ProgressHUD.show()
    }
    
    func dismissLoading() {
        ProgressHUD.dismiss()
    }
    
}
