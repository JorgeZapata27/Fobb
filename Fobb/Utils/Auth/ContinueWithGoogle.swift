//
//  ContinueWithGoogle.swift
//  Fobb
//
//  Created by JJ Zapata on 10/7/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn
import UIKit

extension WelcomeViewController {
    
    func continueWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            guard error == nil else { return showAlert(withTitle: "Error", withDescription: error!.localizedDescription) }
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.showAlert(withTitle: "Error", withDescription: error.localizedDescription)
                    return
                } else {
                    if Auth.auth().currentUser != nil {
                        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                            if snapshot.exists() {
                                self.dismissLoading()
                                self.goToMain()
                            } else {
                                self.dismissLoading()
                                self.updateUserInfo(withMethod: "google")
                                self.goToMain()
                            }
                        }
                    }
                }
            }
        }
    }
}
