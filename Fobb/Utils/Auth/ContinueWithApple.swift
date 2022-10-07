//
//  ContinueWithApple.swift
//  Fobb
//
//  Created by JJ Zapata on 10/7/22.
//

import Foundation
import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseDatabase
import CryptoKit

extension WelcomeViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    func updateUserInfo(withMethod method: String) {
        let infoToAdd : Dictionary<String, Any> = [
            "email" : "\(Auth.auth().currentUser!.email!)",
            "uid" : "\(Auth.auth().currentUser!.uid)",
            "method" : method
        ]
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(infoToAdd)
    }
    
    func toGetName() {
        let controller = GetNameViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    func goToMain() {
        let controller = ViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func continueWithApple() {
        let nonce = self.randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = self.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        showLoading()
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                dismissLoading()
                showAlert(withTitle: "Error", withDescription: "Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                dismissLoading()
                showAlert(withTitle: "Error", withDescription: "Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                dismissLoading()
                showAlert(withTitle: "Error", withDescription: "Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            // MARK: - Continue refactoring
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    self.dismissLoading()
                    self.showAlert(withTitle: "Error".localized(), withDescription: error.localizedDescription)
                    return
                } else {
                    if Auth.auth().currentUser != nil {
                        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                            if snapshot.exists() {
                                self.dismissLoading()
                                self.goToMain()
                            } else {
                                self.dismissLoading()
                                self.updateUserInfo(withMethod: "apple")
                                self.goToMain()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
        let errror = error.localizedDescription
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Sign in with Apple errored: \(errror)")
    }
    
}

