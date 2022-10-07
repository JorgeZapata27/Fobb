//
//  SignUpViewController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    // MARK: - UI Components
    let exitButton = UIButton()
    let scrollView = UIScrollView()
    let appIconImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let emailTextField = MainTextField(placeholderString: "Email".localized())
    let passwordTextField = MainTextField(placeholderString: "Password".localized())
    let loginButton = MainButton(named: "Sign Up".localized())
    var signInButton: SecondaryButton?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
    private func signUpSuccess() {
        updateUserInfo()
        toGetName()
        // go to get name screen
    }
    
    private func toGetName() {
        let controller = GetNameViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    private func updateUserInfo() {
        let infoToAdd : Dictionary<String, Any> = [
            "email" : "\(Auth.auth().currentUser!.email!)",
            "uid" : "\(Auth.auth().currentUser!.uid)"
        ]
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(infoToAdd)
    }
    
}

extension SignUpViewController {
    
    // MARK: - Styling
    func style() {
        view.backgroundColor = UIColor(named: "Background")
        
        // Exit Button
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setImage(UIImage(systemName: "xmark")!.withTintColor(UIColor(named: "TextColor")!), for: [])
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 900)
        scrollView.showsVerticalScrollIndicator = false
        
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
        descriptionLabel.text = "Sign Up".localized()
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = UIColor(named: "TextColor")!
        
        // Email Text Field
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.delegate = self
        
        // Password Text Field
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.textContentType = .oneTimeCode
        
        // Login Button
        loginButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        
        // Sign Up Button
        let signUpTitle = NSMutableAttributedString(string: "Already with us?".localized() + " ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColor")!])
        signUpTitle.append(NSAttributedString(string: "Sign In".localized(), attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor(named: "TextColor")!]))
        signInButton = SecondaryButton(withNSAttributedString: signUpTitle)
        signInButton?.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Layout
    func layout() {
        
        // Scroll View
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        // App Icon Image View
        scrollView.addSubview(appIconImageView)
        NSLayoutConstraint.activate([
            appIconImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 95),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalToConstant: 100),
            appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Title Label
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Description Label
        scrollView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 58),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Email Text Field
        scrollView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 93),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 51)
        ])
        
        // Password Text Field
        scrollView.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 51)
        ])
        
        // Login Button
        scrollView.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 28),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 51)
        ])
        
        // Sign Up Button
        guard let signInButton = signInButton else { return }
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Exit Button
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            exitButton.widthAnchor.constraint(equalToConstant: 25),
            exitButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}

// MARK: - Handlers
extension SignUpViewController {
    
    @objc func exitButtonTapped() {
        print("dismissal")
        dismiss(animated: true)
    }
    
    @objc func mainButtonTapped() {
        showLoading()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if (email.isEmpty) || (password.isEmpty) {
            dismissLoading()
            showAlert(withTitle: "Error".localized(), withDescription: "Both text fields must be filled out".localized())
        } else {
            if email.isValidEmail() {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error == nil {
                        self.dismissLoading()
                        self.signUpSuccess()
                    } else {
                        self.dismissLoading()
                        self.showAlert(withTitle: "Error".localized(), withDescription: error!.localizedDescription)
                    }
                }
            } else {
                dismissLoading()
                showAlert(withTitle: "Invalid Email".localized(), withDescription: "Your email is invalid, please make sure it is formatted correctly".localized())
            }
        }
    }
    
    @objc func signInButtonTapped() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
}

// MARK: - UITextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            mainButtonTapped()
        default:
            textField.resignFirstResponder()
        }
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
