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
    
    //http://flipconnect-signin-staging.herokuapp.com/?clientId=F7F667C7-199F-4A10-B53A-4FADCDFADB53&redirectUri=ipirangaConnect://authorize&responseType=code
    
    var loginFlip: FCLogin!
    
    static let AuthorizationCode = "FCAuthorizationCode"
    static let State = "FCState"
    static let ClientID = "FCClientID"
    static let ClientSecret = "FCClientSecret"
    static let AccessToken = "FCAccessToken"
    static let RefreshToken = "FCRefreshToken"
    static let AccountKey = "FCAccountKey"


    @IBAction func printAllUserDefaults(_ sender: UIButton) {
        print("authCode: \(String(describing: UserDefaults.standard.authorizationCode))")
        print("state: \(String(describing: UserDefaults.standard.state))")
        print("clientID: \(String(describing: UserDefaults.standard.clientID))")
        print("clientSecret: \(String(describing: UserDefaults.standard.clientSecret))")
        print("accessToken: \(String(describing: UserDefaults.standard.accessToken))")
        print("refreshToken: \(String(describing: UserDefaults.standard.refreshToken))")
        print("accountKey: \(String(describing: UserDefaults.standard.accountKey))")
        print("redirectURI: \(String(describing: UserDefaults.standard.redirectURI))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.862, green: 0.862, blue: 0.862, alpha: 1.000)
        
        do {
            loginFlip = try FCLogin()
        } catch {
            print(error)
        }
        
        let btn = loginFlip.loginWithButton(center: view.center)
        
        let btn2 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y - 50), color: .darkGray)
        
        let btn3 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y + 50), color: .white)
        
        view.addSubview(btn)
        view.addSubview(btn2)
        view.addSubview(btn3)
    }

}

