//
//  AppDelegate.swift
//  Fobb
//
//  Created by JJ Zapata on 10/6/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SmartcarAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var smartcar: SmartcarAuth?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        if Auth.auth().currentUser?.uid != nil {
            window?.rootViewController = ViewController()
        } else {
            window?.rootViewController = WelcomeViewController()
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}

