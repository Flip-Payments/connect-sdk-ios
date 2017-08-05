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
        
        guard let fcLogin = Configuration.fcLogin else {
            print("Something went wrong!")
            return
        }
        
        func showSuccessController(unlessError: Bool) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let viewControllerID = unlessError ? "LoginViewController" : "LoginSuccessViewController"
            
            initialViewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)

            DispatchQueue.main.async {
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
        }
        
        if let url = self.url {
            fcLogin.handleRedirect(fromURL: url) { error in
                showSuccessController(unlessError: error != nil)
            }
        } else {
            
            if let token = UserDefaults.standard.accessToken, let accountKey = UserDefaults.standard.accountKey, let publicToken = UserDefaults.standard.publicToken {
                print("Token: \(token)")
                print("Account: \(accountKey)")
                print("Public Token: \(publicToken)")
                
                fcLogin.verifyToken { error in
                    showSuccessController(unlessError: error != nil)
                }
            } else {
                showSuccessController(unlessError: true)
            }
        }
    }
}

