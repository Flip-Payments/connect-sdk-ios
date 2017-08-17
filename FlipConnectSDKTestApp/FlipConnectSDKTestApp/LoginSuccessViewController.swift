//
//  LoginSuccessViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 12/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class LoginSuccessViewController: UIViewController {
    
    var fcLogin: FCLogin!
    
    var window: UIWindow?
    
    @IBOutlet weak var environmentSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Configuration.environment {
        case .production:
            self.environmentSwitch.setOn(true, animated: false)
        case .sandbox:
            self.environmentSwitch.setOn(false, animated: false)
        }
        
        guard let fcLogin = Configuration.fcLogin else {
            return
        }
        
        self.fcLogin = fcLogin
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func refreshBtnPressed(_ sender: UIButton) {
        FCApi.requestTokenRefresh() { tokenResponse, error in
            guard error == nil else {
                Configuration.showErrorDialog("\(error!)", on: self)
                return
            }
            
            if tokenResponse.success {
                // DO SOMETHING
                print("Refreshed with success")
                print("AccessToken: \(tokenResponse.accessToken!)")
                print("UserKey: \(tokenResponse.userKey!)")
                print("RefreshToken: \(tokenResponse.refreshToken!)")
            } else {
                // ERROR HANDLING
                var message = ""
                for report in tokenResponse.operationReport {
                    message.append("\(report.field) - \(report.message)")
                }
                Configuration.showErrorDialog(message, on: self)
            }
        }
    }
    
    private func logout() {
        FCApi.requestTokenRevocation() { tokenResponse, error in
            guard error == nil else {
                Configuration.showErrorDialog("\(error!)", on: self)
                return
            }
            
            if tokenResponse.success {
                // DO SOMETHING
                print("Logged out")
                print("AccessToken: \(tokenResponse.accessToken ?? "Nil Token")")
                print("UserKey: \(tokenResponse.userKey ?? "Nil Token")")
                print("RefreshToken: \(tokenResponse.refreshToken ?? "Nil Token")")
            } else {
                // ERROR HANDLING
                var message = ""
                for report in tokenResponse.operationReport {
                    message.append("\(report.field) - \(report.message)")
                }
                Configuration.showErrorDialog(message, on: self)
            }
        }
        
        var initialViewController = UIViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewControllerID = "LoginViewController"
        
        initialViewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        DispatchQueue.main.async {
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        self.logout()
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        Configuration.environment = sender.isOn ? FCEnvironmentEnum.production : FCEnvironmentEnum.sandbox
        self.logout()
    }

    @IBAction func switchStagingValueChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            Configuration.environment = FCEnvironmentEnum(rawValue: "staging")
        case false && Configuration.environment == .production:
            Configuration.environment = FCEnvironmentEnum(rawValue: FCEnvironmentEnum.production.rawValue)
        case false && Configuration.environment == .sandbox:
            Configuration.environment = FCEnvironmentEnum(rawValue: FCEnvironmentEnum.sandbox.rawValue)
        default:
            break
        }
        self.logout()
    }
    @IBAction func verifyBtnPressed(_ sender: UIButton) {
        FCApi.requestTokenVerification() { tokenResponse, error in
            guard error == nil else {
                Configuration.showErrorDialog("\(error!)", on: self)
                return
            }
            
            if tokenResponse.success {
                // DO SOMETHING
                print("Verified with success")
                print("AccessToken: \(tokenResponse.accessToken!)")
                print("UserKey: \(tokenResponse.userKey!)")
            } else {
                // ERROR HANDLING
                var message = ""
                for report in tokenResponse.operationReport {
                    message.append("\(report.field) - \(report.message)")
                }
                Configuration.showErrorDialog(message, on: self)
            }
        }
    }
}
