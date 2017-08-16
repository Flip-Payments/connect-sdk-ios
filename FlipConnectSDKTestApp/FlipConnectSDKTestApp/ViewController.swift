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
    
    var initialViewController = UIViewController()
    
    func showSuccessController(unlessError: Bool, errorText: String? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewControllerID = unlessError ? "LoginViewController" : "LoginSuccessViewController"
        
        initialViewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        DispatchQueue.main.async {
            self.window?.rootViewController = self.initialViewController
            self.window?.makeKeyAndVisible()
            if unlessError, let error = errorText {
                Configuration.showErrorDialog(error, on: self.initialViewController)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let fcLogin = Configuration.fcLogin else {
            print("Something went wrong!")
            Configuration.showErrorDialog("FCLogin não instanciado", on: self)
            return
        }
        
        if let url = self.url {
            fcLogin.handleRedirect(fromURL: url) { tokenResponse, error in
                if tokenResponse.success {
                    // DO SOMETHING
                    print(tokenResponse.accessToken!)
                    print(tokenResponse.userKey!)
                    print(tokenResponse.refreshToken!)
                }
                
                self.showSuccessController(unlessError: error != nil || !tokenResponse.success,
                                           errorText: error?.localizedDescription ?? tokenResponse.operationReport.first?.message)
            }
        } else {
            
            if let token = UserDefaults.standard.accessToken, let accountKey = UserDefaults.standard.userKey {
                print("Token: \(token)")
                print("Account: \(accountKey)")
                
                FCApi.requestTokenVerification() { _, error in
                    self.showSuccessController(unlessError: error != nil, errorText: error?.localizedDescription)
                }
            } else {
                self.showSuccessController(unlessError: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
    }
}

