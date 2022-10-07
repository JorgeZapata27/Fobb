//
//  ViewController.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

import Alamofire
import SmartcarAuth

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var vehicleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Authorization Step 1: Initialize the Smartcar object
        
        appDelegate.smartcar = SmartcarAuth(clientId: Constants.clientId, redirectUri: "sc\(Constants.clientId)://exchange", scope: ["required:read_vehicle_info"], completionHandler: { err, code, state in
            <#code#>
        })
        
        // display a button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.addTarget(self, action: #selector(connectPressed), for: .touchUpInside)
        button.setTitle("Connect your vehicle", for: .normal)
        button.backgroundColor = UIColor.black
        self.view.addSubview(button)
        
        view.backgroundColor = UIColor(named: "Background")
        
        let myButton = UIButton(type: .system)
        myButton.setTitle("Sign Out", for: [])
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        view.addSubview(myButton)
        myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
    
    @objc func connectPressed() {
        let smartcar = appDelegate.smartcar!
        smartcar.launchAuthFlow(url: url, viewController: self)
    }
    
    
    
    
    
    // smartcar tutorial stuff
    
    
    func completion(err: Error?, code: String?, state: String?) -> Any {
        // TODO: Authorization Step 3b: Receive an authorization code
        
        // TODO: Request Step 1: Obtain an access token
        
        // TODO: Request Step 2: Get vehicle information
        
        return ""
    }
    
    
}

