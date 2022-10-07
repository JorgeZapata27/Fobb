//
//  MainButton.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit

class MainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sharedLayout()
    }
    
    init(named title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: [])
        setTitleColor(UIColor(named: "TextColorButton")!, for: [])
        sharedLayout()
    }
    
    init(withNSAttributedString attString: NSAttributedString, isApple: Bool?) {
        super.init(frame: .zero)
        
        sharedLayout()
        setAttributedTitle(attString, for: [])
        
        if isApple ?? false {
            backgroundColor = .black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        sharedLayout()
    }
    
    private func sharedLayout() {
        
        addTarget(self, action: #selector(hapticFeedback), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        layer.cornerRadius = 15
        backgroundColor = UIColor(named: "MainButtonBackground")
        setTitleColor(UIColor(named: "TextColorButton"), for: [])
    }

}

extension MainButton {
    
    @objc func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}
