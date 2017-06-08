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
    
    var loginFlip: FCLogin!

    @IBAction func printAllUserDefaults(_ sender: UIButton) {
        print("accessToken: \(String(describing: UserDefaults.standard.accessToken))")
        print("refreshToken: \(String(describing: UserDefaults.standard.refreshToken))")
        print("clientID: \(String(describing: UserDefaults.standard.clientID))")
        print("authCode: \(String(describing: UserDefaults.standard.authorizationCode))")
        print("state: \(String(describing: UserDefaults.standard.state))")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            loginFlip = try FCLogin()
        } catch {
            print(error)
        }
        
        loginFlip.openLoginURL()
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("Login to FlipConnect", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
    }

    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        loginFlip.openLoginURL()
    }


}

