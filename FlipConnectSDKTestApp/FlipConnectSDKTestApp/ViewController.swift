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
        print("accessToken: \(String(describing: UserDefaults.standard.accessToken))")
        print("accountKey: \(String(describing: UserDefaults.standard.accountKey))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.862, green: 0.862, blue: 0.862, alpha: 1.000)
        
        let vc = FCEditUser()
        
        do {
            loginFlip = try FCLogin.shared()
        } catch {
            print(error)
        }
        
        let btn = loginFlip.loginWithButton(center: view.center)
        
        let btn2 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y - 50), color: .darkGray)
        
        let btn3 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y + 50), color: .white)
        
        view.addSubview(btn)
        view.addSubview(btn2)
        view.addSubview(btn3)
        
        //        let v = vc.loadView()
        vc.loadView { viewController in
            self.present(viewController, animated: true, completion: nil)
        }
        //        DispatchQueue.main.async {
        //            self.present(v, animated: true, completion: nil)
        //        }
        
        //        self.present(v, animated: true, completion: nil)
        
        //self.navigationController!.present(v, animated: true, completion: nil)
    }
    
    @IBAction func refreshTokenBtn(_ sender: UIButton) {
        loginFlip.verifyToken() { err in
            guard err == nil else {
                print("no success verifying")
                print(err!)
                return
            }
            print("Tokens verified")
            print("NewToken: \(String(describing: UserDefaults.standard.accessToken))")
            print("NewAccessKey: \(String(describing: UserDefaults.standard.accountKey))")
        }
        
        loginFlip.refreshToken() { err in
            guard err == nil else {
                print("refresh with no success")
                print(err!)
                return
            }
            
            print("Tokens Refreshed")
            print("NewToken: \(String(describing: UserDefaults.standard.accessToken))")
            print("NewAccessKey: \(String(describing: UserDefaults.standard.accountKey))")
        }
    }
}

