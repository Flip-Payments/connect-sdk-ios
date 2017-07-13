//
//  LoginViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 30/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class LoginViewController: UIViewController {

    //http://flipconnect-signin-staging.herokuapp.com/?clientId=F7F667C7-199F-4A10-B53A-4FADCDFADB53&redirectUri=ipirangaConnect://authorize&responseType=code
    
    var loginFlip: FCLogin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.862, green: 0.862, blue: 0.862, alpha: 1.000)
        
//        let vc = FCEditUser()
        
        do {
            loginFlip = try FCLogin.shared()
            let btn = loginFlip.loginWithButton(center: view.center)
            
            let btn2 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y - 50), color: .darkGray)
            
            let btn3 = loginFlip.loginWithButton(center: CGPoint(x: view.center.x, y: view.center.y + 50), color: .white)
            
            view.addSubview(btn)
            view.addSubview(btn2)
            view.addSubview(btn3)
        } catch {
            print(error)
        }
        
//        vc.loadView { viewController in
//            self.present(viewController, animated: true, completion: nil)
//        }
    }

}
