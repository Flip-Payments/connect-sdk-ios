//
//  FCLogin.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation
import UIKit
import FingerPrint_iOS

public class FCLogin {
    var redirectHandler: FCRedirectHandler
    
    /// entity used to load registration data on login web form
    public var temporaryProfile: TemporaryProfile? = nil
    
    private init(_ configuration: FCConfiguration) throws {
        redirectHandler = try FCRedirectHandler(bundle: Bundle.main.infoDictionary)
        
        if let fingerPrintID = FCConfiguration.fingerPrintID, let accessToken = UserDefaults.standard.accessToken {
            self.callFingerPrint(fingerPrintID: fingerPrintID, accessToken: accessToken)
        }
    }
    
    private func callFingerPrint(fingerPrintID: String, accessToken: String) {
        let uuid = UUID().uuidString
        UserDefaults.standard.fingerPrintSessionID = uuid
        FingerPrintLibrary.initFingerprint(role: FCConfiguration.environment.rawValue, key: fingerPrintID, registerId: accessToken, sessionId: uuid) // "c470458e-7845-4380-a5db-e7e28548c243"
        FingerPrintLibrary.configFingerprint(phoneData: true, contactList: true, location: true)
        FingerPrintLibrary.getFingerprint()
    }
    
    private static var sharedVar: FCLogin?
    
    /**
     - Parameters:
     - configuration: it should contain the necessary information to use on the API
     - Returns: Singleton instance of FCLogin
     
     */
    public static func shared(configuration: FCConfiguration) throws -> FCLogin {
        if sharedVar == nil {
            do {
                sharedVar = try FCLogin(configuration)
            } catch {
                throw error
            }
        }
        
        return sharedVar!
    }
    
    /**
     - Returns: Singleton instance of FCLogin if it was already instantiated
     
     */
    public static func shared() throws -> FCLogin {
        guard let login = sharedVar else {
            throw FCErrors.classNotInstatiated
        }
        
        return login
    }
    
    /// Generates button targeting login web page on Safari
    ///
    /// - Parameters:
    ///   - center: position of the button
    ///   - frame: frame size of the butto
    ///   - color: color of the button
    ///   - title: title of the button
    ///   - temporaryProfile: used to load registration data on login web form
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
        if let temporaryProfile = self.temporaryProfile {
            FCApi.createTemporaryProfile(temporaryProfile) { response, error in
                let url = self.redirectHandler.mountWebURL(url: URL(string: FCConfiguration.environment.webURL)!,
                                                           withRedirectUri: FCConfiguration.redirectURI,
                                                           andID: FCConfiguration.clientID,
                                                           dataKey: response.dataKey)
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else {
            let url = self.redirectHandler.mountWebURL(url: URL(string: FCConfiguration.environment.webURL)!,
                                                       withRedirectUri: FCConfiguration.redirectURI,
                                                       andID: FCConfiguration.clientID)
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    /**
     Handles redirect from login for token creation
     
     - Parameters:
     - fromURL: URL received from Redirect
     - completion: Callback
     - tokenResponse: Is not nil when the execution is successfull
     - error: Is not nil when the execution is unsuccessfull
     */
    public func handleRedirect(fromURL url: URL, completion: @escaping (_ tokenResponse: TokenResponse?, _ error: Error?) -> Void) {
        var err: Error? = nil
        
        do {
            try redirectHandler.handleURI(open: url)
        } catch {
            err = error
            completion(nil, err)
            return
        }
        
        FCApi.requestAccessToken() { resp, error in
                                    guard error == nil else {
                                        completion(resp, error)
                                        return
                                    }
                                    
                                    if resp.success,
                                        let fingerPrintID = FCConfiguration.fingerPrintID,
                                        let accessToken = UserDefaults.standard.accessToken {
                                        self.callFingerPrint(fingerPrintID: fingerPrintID, accessToken: accessToken)
                                    }
                                    
                                    completion(resp, err)
        }
    }
}
