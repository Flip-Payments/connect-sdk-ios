//
//  FCLogin.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation
import UIKit

public class FCLogin {
    var plistHelper: PlistHelper
    var redirectHandler: FCRedirectHandler
    
    public init() throws {
        plistHelper = try PlistHelper(bundle: Bundle.main.infoDictionary)
        redirectHandler = try FCRedirectHandler(bundle: Bundle.main.infoDictionary)
    }
        
    public func loginWithButton(center: CGPoint, frame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 40), color: FCColors.Colors = .green, title: String = "Login to FlipConnect") -> UIButton {
        let buttonColor = FCColors.getUIColor(color)
        
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = buttonColor.fromButton
        myLoginButton.setTitleColor(buttonColor.fromText, for: UIControlState.normal)
        myLoginButton.frame = frame
        myLoginButton.center = center;
        myLoginButton.setTitle(title, for: .normal)
        myLoginButton.layer.cornerRadius = 20
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        return myLoginButton
    }
    
    @objc public func loginButtonClicked() {
        openLoginURL()
    }
    
    /// Opens Safari with Login Page
    public func openLoginURL() {
        if let clientID = UserDefaults.standard.clientID {
            let url = redirectHandler.mountWebURL(withRedirectUri: URL(string: FCConsts.connectWebUrl)!, andID: clientID)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Handles redirect from login for token creation
    public func handleRedirect(fromURL url: URL, completion: @escaping (_ response: String, _ error: Error?) -> Void) {
        var response = ""
        var err: Error? = nil
        
        do {
            try redirectHandler.handleURI(open: url)
        } catch {
            err = error
            completion(response, err)
        }
        
        guard let authCode = UserDefaults.standard.authorizationCode,
              let clientSecret = UserDefaults.standard.clientSecret,
              let clientID = UserDefaults.standard.clientID,
              let redirectURI = UserDefaults.standard.redirectURI else {
            err = FCErrors.invalidOperation
            completion(response, err)
            return
        }
        
        FCApi.requestAccessToken(authorizationCode: authCode, redirectUri: redirectURI, clientSecret: clientSecret, clientID: clientID) { resp, error in
            guard error == nil else {
                print("deu merda \(error.debugDescription)")
                completion(response, error)
                return
            }
            
            let isToken = resp["accessToken"] as? String
            
            guard let token = isToken else {
                let operationReport = resp["operationReport"] as? [JSON]
                var message = ""
                if let or = operationReport {
                    for operation in or {
                        for item in operation {
                            message += "\(item.key): \(item.value) "
                        }
                    }
                }
                completion(response, FCErrors.requestUnsuccessful(message: message))
                return
            }
            response = token
            
            UserDefaults.standard.accessToken = response
            completion(response, err)
        }
    }
}
