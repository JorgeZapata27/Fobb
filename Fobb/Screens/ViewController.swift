//
//  ViewController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.text = "Hello".localized()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myLabel)
        myLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("Users").child(uid).child("name").observeSingleEvent(of: .value) { snapshot in
                if let _ = snapshot.value as? String {
                    print("we have a name")
                } else {
                    // if user doesn't have a name, go to getname
                    let controller = GetNameViewController()
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            }
        } else {
            print("cannot find user status")
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func signOut() {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        dismiss(animated: true)
    }
    
    
}

