//
//  WelcomeViewController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    // MARK: - UI Components
    let appIconImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    var loginButton: MainButton?
    var googleButton: MainButton?
    var appleButton: MainButton?
    var signUpButton: SecondaryButton?
    
    // MARK: - Variables
    var currentNonce: String?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
}

extension WelcomeViewController {
    
    // MARK: - Styling
    func style() {
        view.backgroundColor = UIColor(named: "Background")
        
        // App Icon Image View
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.image = UIImage(named: "rounded-logo")
        appIconImageView.contentMode = .scaleAspectFill
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Fobb."
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "TextColor")!
        
        // Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Your Digital Car Key".localized()
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = UIColor(named: "TextColor")!
        
        // Login Button
        let loginTitle = NSMutableAttributedString(string: "Login with ".localized(), attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColorButton")!])
        loginTitle.append(NSAttributedString(string: "Email", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColorButton")!]))
        loginButton = MainButton(withNSAttributedString: loginTitle, isApple: false)
        loginButton?.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        
        // Google Button
        let googleTitle = NSMutableAttributedString(string: "Continue with ".localized(), attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColorButton")!])
        googleTitle.append(NSAttributedString(string: "G", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-g")!]))
        googleTitle.append(NSAttributedString(string: "o", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-oe")!]))
        googleTitle.append(NSAttributedString(string: "o", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-o2")!]))
        googleTitle.append(NSAttributedString(string: "g", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-g")!]))
        googleTitle.append(NSAttributedString(string: "l", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-l")!]))
        googleTitle.append(NSAttributedString(string: "e", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "Google-oe")!]))
        googleButton = MainButton(withNSAttributedString: googleTitle, isApple: false)
        googleButton?.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        
        // Apple Button
        let appleTitle = NSMutableAttributedString(string: "Continue with ".localized(), attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        appleTitle.append(NSAttributedString(string: "Apple", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        appleButton = MainButton(withNSAttributedString: appleTitle, isApple: true)
        appleButton?.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
        
        // Sign Up Button
        let signUpTitle = NSMutableAttributedString(string: "New to Fobb?".localized() + " ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColor")!])
        signUpTitle.append(NSAttributedString(string: "Get Started".localized(), attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColor")!]))
        signUpButton = SecondaryButton(withNSAttributedString: signUpTitle)
        signUpButton?.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Layout
    func layout() {
        
        // App Icon Image View
        view.addSubview(appIconImageView)
        NSLayoutConstraint.activate([
            appIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalToConstant: 100),
            appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Title Label
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Description Label
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 58),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Login Button
        guard let loginButton = loginButton else { return }
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 78),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        // Login Button
        guard let googleButton = googleButton else { return }
        view.addSubview(googleButton)
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 21),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            googleButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        // Login Button
        guard let appleButton = appleButton else { return }
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 21),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            appleButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        // Sign Up Button
        guard let signUpButton = signUpButton else { return }
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

// MARK: - Handlers
extension WelcomeViewController {
    
    @objc func emailTapped() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    @objc func googleTapped() {
        continueWithGoogle()
    }
    
    @objc func appleTapped() {
        continueWithApple()
    }
    
    @objc func getStartedTapped() {
        let controller = SignUpViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
}
