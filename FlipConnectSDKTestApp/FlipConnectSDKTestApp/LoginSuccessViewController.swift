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
    
    @IBOutlet weak var authorizationCodeLbl: UILabel!
    @IBOutlet weak var accessTokenLbl: UILabel!
    @IBOutlet weak var refreshTokenLbl: UILabel!
    @IBOutlet weak var clientIDLbl: UILabel!
    @IBOutlet weak var clientSecretLbl: UILabel!
    @IBOutlet weak var accountKeyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try loginFlip = FCLogin.shared()
        } catch {
            let alertController = UIAlertController(title: "Erro", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        accessTokenLbl.text = UserDefaults.standard.accessToken
        accountKeyLbl.text = UserDefaults.standard.accountKey
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func refreshToken(_ sender: UIButton) {
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
            self.accessTokenLbl.text = UserDefaults.standard.accessToken
            self.accountKeyLbl.text = UserDefaults.standard.accountKey
        }
    }

    @IBAction func verifyToken(_ sender: UIButton) {
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
            self.accessTokenLbl.text = UserDefaults.standard.accessToken
            self.accountKeyLbl.text = UserDefaults.standard.accountKey
        }
    }
}
