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
    public var temporaryProfile: TemporaryProfile? = nil
    
    private init() throws {
        plistHelper = try PlistHelper(bundle: Bundle.main.infoDictionary)
        redirectHandler = try FCRedirectHandler(bundle: Bundle.main.infoDictionary)
    }
    
    private static var sharedVar: FCLogin?
    
    /// Singleton instance of FCLogin
    public static func shared() throws -> FCLogin {
        if sharedVar == nil {
            do {
                sharedVar = try FCLogin()
            } catch {
                throw error
            }
        }
        
        return sharedVar!
    }
    
    /// Generates button targeting login web page on Safari
    ///
    /// - Parameters:
    ///   - center: position of the button
    ///   - frame: frame size of the butto
    ///   - color: color of the button
    ///   - title: title of the button
    /// - Returns: A `UIButton` targeting a Safari web page to login
    public func loginWithButton(center: CGPoint, frame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 40), color: FCColors.Colors = .green, title: String = "FlipConnect Login", temporaryProfile: TemporaryProfile? = nil) -> UIButton {
        if self.temporaryProfile == nil {
            self.temporaryProfile = temporaryProfile
        }
        
        let buttonColor = FCColors.getUIColor(color)
        
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = buttonColor.fromButton
        myLoginButton.setTitleColor(buttonColor.fromText, for: UIControlState.normal)
        myLoginButton.frame = frame
        myLoginButton.center = center;
        myLoginButton.setTitle(title, for: .normal)
        myLoginButton.layer.cornerRadius = 20
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        
        return myLoginButton
    }
    
    /// Calls login web page
    @objc public func loginButtonClicked() {
        openLoginURL()
    }
    
    /// Opens Safari with Login Page
    public func openLoginURL() {
        if let clientID = UserDefaults.standard.clientID, let redirectURI = UserDefaults.standard.redirectURI {
            
            if let temporaryProfile = self.temporaryProfile {
                FCApi.createTemporaryProfile(temporaryProfile, clientID: clientID) { response, error in
                    let url = self.redirectHandler.mountWebURL(url: URL(string: FCConsts.connectWebUrl)!, withRedirectUri: redirectURI, andID: clientID, dataKey: response.dataKey)
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } else {
                let url = self.redirectHandler.mountWebURL(url: URL(string: FCConsts.connectWebUrl)!, withRedirectUri: redirectURI, andID: clientID)
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    /// Refreshes token to access the API
    ///
    /// - Parameters:
    ///    - completion: error received from callback
    public func refreshToken(completion: @escaping (_ error: Error?) -> Void) {
        var err: Error? = nil
        
        guard let refreshToken = UserDefaults.standard.refreshToken,
            let clientSecret = UserDefaults.standard.clientSecret,
            let clientID = UserDefaults.standard.clientID,
            let redirectURI = UserDefaults.standard.redirectURI else {
                err = FCErrors.invalidOperation
                completion(err)
                return
        }
        
        FCApi.requestNewToken(refreshToken: refreshToken, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI) { resp, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            let isToken = resp["accessToken"] as? String
            let isRefreshToken = resp["refreshToken"] as? String
            let isAccountKey = resp["userKey"] as? String
            
            guard let token = isToken, let refreshToken = isRefreshToken, let accountKey = isAccountKey else {
                let operationReport = resp["operationReport"] as? [JSON]
                var message = ""
                if let or = operationReport {
                    for operation in or {
                        for item in operation {
                            message += "\(item.key): \(item.value) "
                        }
                    }
                }
                completion(FCErrors.requestUnsuccessful(message: message))
                return
            }
            
            UserDefaults.standard.accessToken = token
            UserDefaults.standard.refreshToken = refreshToken
            UserDefaults.standard.accountKey = accountKey
            completion(err)
        }
    }
    
    /// Verify if the token is valid
    ///
    /// - Parameters:
    ///    - completion: error received from callback
    public func verifyToken(completion: @escaping (_ error: Error?) -> Void) {
        var err: Error? = nil
        
        guard let accessToken = UserDefaults.standard.accessToken,
            let clientSecret = UserDefaults.standard.clientSecret,
            let clientID = UserDefaults.standard.clientID else {
                err = FCErrors.invalidOperation
                completion(err)
                return
        }
        
        FCApi.requestVerifyToken(accessToken: accessToken, clientID: clientID, clientSecret: clientSecret) { resp, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            let isToken = resp["accessToken"] as? String
            let isAccessToken = resp["refreshToken"] as? String
            let isAccountKey = resp["userKey"] as? String
            
            guard let token = isToken, let refreshToken = isAccessToken, let accountKey = isAccountKey else {
                let operationReport = resp["operationReport"] as? [JSON]
                var message = ""
                if let or = operationReport {
                    for operation in or {
                        for item in operation {
                            message += "\(item.key): \(item.value) "
                        }
                    }
                }
                completion(FCErrors.requestUnsuccessful(message: message))
                return
            }
            
            UserDefaults.standard.accessToken = token
            UserDefaults.standard.refreshToken = refreshToken
            UserDefaults.standard.accountKey = accountKey
            completion(err)
        }
    }
    
    /**
     Get public token to use with public API
     
     - Parameters:
        - completion: Callback
        - error: Is not nil when the execution is unsuccessfull
    */
    public func publicToken(completion: @escaping (_ error: Error?) -> Void) {
        var err: Error? = nil
        
        guard let clientSecret = UserDefaults.standard.clientSecret,
            let clientID = UserDefaults.standard.clientID else {
                err = FCErrors.invalidOperation
                completion(err)
                return
        }
        
        FCApi.requestPublicToken(clientID: clientID , clientSecret: clientSecret) { res, err in
            guard err == nil else {
                completion(err)
                return
            }
            
            let isPublicToken = res["accessToken"] as? String
            
            guard let publicToken = isPublicToken else {
                let operationReport = res["operationReport"] as? [JSON]
                var message = ""
                if let or = operationReport {
                    for operation in or {
                        for item in operation {
                            message += "\(item.key): \(item.value) "
                        }
                    }
                }
                completion(FCErrors.requestUnsuccessful(message: message))
                return
            }
            
            UserDefaults.standard.publicToken = publicToken
            completion(err)
        }
    }
    
    /**
     Handles redirect from login for token creation
    
     - Parameters:
        - fromURL: URL received from Redirect
        - completion: Callback
        - error: Is not nil when the execution is unsuccessfull
    */
    public func handleRedirect(fromURL url: URL, completion: @escaping (_ error: Error?) -> Void) {
        var err: Error? = nil
        
        do {
            try redirectHandler.handleURI(open: url)
        } catch {
            err = error
            completion(err)
            return
        }
        
        guard let authCode = UserDefaults.standard.authorizationCode,
              let clientSecret = UserDefaults.standard.clientSecret,
              let clientID = UserDefaults.standard.clientID,
              let redirectURI = UserDefaults.standard.redirectURI else {
            err = FCErrors.invalidOperation
            completion(err)
            return
        }
        
        FCApi.requestAccessToken(authorizationCode: authCode, redirectUri: redirectURI, clientSecret: clientSecret, clientID: clientID) { resp, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            let isToken = resp["accessToken"] as? String
            let isRefreshToken = resp["refreshToken"] as? String
            let isAccountKey = resp["userKey"] as? String
            
            guard let token = isToken, let refreshToken = isRefreshToken, let accountKey = isAccountKey else {
                let operationReport = resp["operationReport"] as? [JSON]
                var message = ""
                if let or = operationReport {
                    for operation in or {
                        for item in operation {
                            message += "\(item.key): \(item.value) "
                        }
                    }
                }
                completion(FCErrors.requestUnsuccessful(message: message))
                return
            }
            
            UserDefaults.standard.accessToken = token
            UserDefaults.standard.refreshToken = refreshToken
            UserDefaults.standard.accountKey = accountKey
            completion(err)
        }
    }
}
