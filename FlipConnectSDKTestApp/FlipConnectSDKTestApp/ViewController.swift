//
//  ViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var url: URL? = nil
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        
        var initialViewController = UIViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        do {
            let loginFlip = try FCLogin.shared()
            
            if let url = self.url {
                loginFlip.handleRedirect(fromURL: url) { error in
                    
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    
                    if let error = error {
                        print(error)
                        initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    } else {
                        initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSuccessViewController")
                    }
                    
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
                }
            } else {
                
                if let token = UserDefaults.standard.accessToken, let accountKey = UserDefaults.standard.accountKey, let publicToken = UserDefaults.standard.publicToken {
                    print("Token: \(token)")
                    print("Account: \(accountKey)")
                    print("Public Token: \(publicToken)")
                    
                    loginFlip.verifyToken { error in
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        if let error = error {
                            print(error)
                            initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                        } else {
                            initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSuccessViewController")
                        }
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
                } else {
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
                }
            }
            
        } catch {
            print(error)
        }
    }
}

