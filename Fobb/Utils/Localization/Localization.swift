//
//  Localization.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
        
    }
    
}
