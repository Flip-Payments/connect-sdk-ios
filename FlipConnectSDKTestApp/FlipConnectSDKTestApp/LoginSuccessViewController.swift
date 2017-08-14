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
    
    func refreshToken() {
        
        FCApi.requestTokenRefresh() { tokenResponse, error in
            guard error == nil else {
                self.showErrorDialog("\(error!)")
                return
            }
            
            if tokenResponse.success {
                // DO SOMETHING
                print(tokenResponse.accessToken!)
                print(tokenResponse.userKey!)
                print(tokenResponse.refreshToken!)
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

    func verifyToken() {
        FCApi.requestTokenVerification() { tokenResponse, error in
            guard error == nil else {
                self.showErrorDialog("\(error!)")
                return
            }
            
            if tokenResponse.success {
                // DO SOMETHING
                print(tokenResponse.accessToken!)
                print(tokenResponse.userKey!)
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
