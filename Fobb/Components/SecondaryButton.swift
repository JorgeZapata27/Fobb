//
//  SecondaryButton.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit

class SecondaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sharedLayout()
    }
    
    init(named title: String) {
        super.init(frame: .zero)
        
        titleLabel?.text = title
        sharedLayout()
    }
    
    init(withNSAttributedString attString: NSAttributedString) {
        super.init(frame: .zero)
        
        setAttributedTitle(attString, for: [])
        sharedLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        sharedLayout()
    }
    
    private func sharedLayout() {
        addTarget(self, action: #selector(hapticFeedback), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        backgroundColor = .clear
        setTitleColor(UIColor(named: "TextColor")!, for: [])
    }

}

extension SecondaryButton {
    
    @objc func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}
