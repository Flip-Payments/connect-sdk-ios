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
        
    public func loginWithButton(center: CGPoint, frame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 40), color: FCColors = .green, title: String = "Login to FlipConnect") {
        let buttonColor = FCColorHelper.getUIColor(color: color)
        
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = buttonColor.fromButton
        myLoginButton.setTitleColor(buttonColor.fromText, for: UIControlState.normal)
        myLoginButton.frame = frame
        myLoginButton.center = center;
        myLoginButton.setTitle(title, for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)        
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
    public func handleRedirect(fromURL url: URL) throws {
        try redirectHandler.handleURI(open: url)
        guard let authCode = UserDefaults.standard.authorizationCode else {
            return
        }
        FCApi.requestAccessToken(authorizationCode: authCode, redirectUri: redirectHandler.urlScheme) { resp, error in
            guard error == nil else {
                print("deu merda \(error.debugDescription)")
                return
            }
            
            //TODO ver porque essa porra tá zoada
            guard let token = resp["accessToken"] as? String else {
                print("não consegui pegar o token")
                return
            }
            
            UserDefaults.standard.accessToken = token
        }
    }
}
