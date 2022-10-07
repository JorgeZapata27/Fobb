//
//  GetNameViewController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

class GetNameViewController: UIViewController {
    
    // MARK: - UI Components
    let scrollView = UIScrollView()
    let appIconImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let nameTextField = MainTextField(placeholderString: "Your Full Name".localized())
    let mainButton = MainButton(named: "Save Information".localized())

    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        style()
        layout()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
}

extension GetNameViewController {
    
    // MARK: - Styling
    func style() {
        view.backgroundColor = UIColor(named: "Background")
        
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
        titleLabel.text = "Welcome to Fobb!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "TextColor")!
        
        // Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "What's your name?".localized()
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = UIColor(named: "TextColor")!
        
        // Email Text Field
        nameTextField.delegate = self
        
        // Login Button
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
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
            titleLabel.widthAnchor.constraint(equalToConstant: 400),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Description Label
        scrollView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 400),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 58),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Name Text Field
        scrollView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 93),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 51)
        ])
        
        // Login Button
        scrollView.addSubview(mainButton)
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 28),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    
}

extension GetNameViewController {
    
    @objc func mainButtonTapped() {
        let name = nameTextField.text ?? ""
        if !name.isEmpty {
            showLoading()
            Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("name").setValue(name) { error, ref in
                if error == nil {
                    self.dismissLoading()
                    self.dismiss(animated: true)
                } else {
                    self.showAlert(withTitle: "Error".localized(), withDescription: error!.localizedDescription)
                }
            }
        } else {
            showAlert(withTitle: "Error".localized(), withDescription: "Text field should be filled in".localized())
        }
    }
    
}

// MARK: - UITextField Delegate
extension GetNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            mainButtonTapped()
            textField.resignFirstResponder()
            break
        default:
            break
        }
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
