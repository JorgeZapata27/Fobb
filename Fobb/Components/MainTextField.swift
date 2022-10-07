//
//  MainTextField.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit

class MainTextField : UITextField {

    let insets : UIEdgeInsets

    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12), placeholderString: String) {
        self.insets = insets
        super.init(frame: .zero)

        placeholder = placeholderString
        tintColor = UIColor.themeColor
        font = UIFont.systemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "TextColor")!.cgColor
        textColor = UIColor(named: "TextColor")!
        backgroundColor = .clear
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not yet been implemented")
    }

}
