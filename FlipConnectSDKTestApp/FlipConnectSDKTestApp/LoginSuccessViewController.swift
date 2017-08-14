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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fcLogin = Configuration.fcLogin else {
            return
        }
        
        self.fcLogin = fcLogin
    }
    
    func showErrorDialog(_ error: String) {
        let alertController = UIAlertController(title: "Erro", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
                self.showErrorDialog("\(error!)")
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
                self.showErrorDialog(message)
            }
        }
    }
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        FCApi.requestTokenRevocation() { tokenResponse, error in
            guard error == nil else {
                self.showErrorDialog("\(error!)")
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
                self.showErrorDialog(message)
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

    @IBAction func verifyBtnPressed(_ sender: UIButton) {
        FCApi.requestTokenVerification() { tokenResponse, error in
            guard error == nil else {
                self.showErrorDialog("\(error!)")
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
                self.showErrorDialog(message)
            }
        }
    }
}
