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
    
    var loginFlip: FCLogin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try loginFlip = FCLogin.shared(configuration: Configuration.shared)
        } catch {
            let alertController = UIAlertController(title: "Erro", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
        loginFlip.refreshToken{ error in
            guard error == nil else {
                let alertController = UIAlertController(title: "Erro", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }

    func verifyToken() {
        loginFlip.verifyToken { error in
            guard error == nil else {
                let alertController = UIAlertController(title: "Erro", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
}
