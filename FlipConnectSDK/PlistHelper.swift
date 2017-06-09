//
//  PlistHelper.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct PlistHelper {
    private static let clientIDKey = "ClientID"
    private static let clientSecretKey = "ClientSecret"
    private static let redirectURIKey = "RedirectURI"
    
    init(bundle jsonArray: JSON?) throws {
        guard let plist = jsonArray else {
            throw FCErrors.plistNotFound
        }
        
        guard let config = plist["FlipConnectSDK"] as? JSON, !config.isEmpty else {
            throw FCErrors.configNotFound
        }
        
        let isClientID = config[PlistHelper.clientIDKey] as? String
        let isClientSecret = config[PlistHelper.clientSecretKey] as? String
        let isRedirectURI = config[PlistHelper.redirectURIKey] as? String
        
        guard let clientID = isClientID, let clientSecret = isClientSecret, let redirectURI = isRedirectURI else {
            throw FCErrors.incorrectIdentifier
        }
        
        UserDefaults.standard.clientID = clientID
        UserDefaults.standard.clientSecret = clientSecret
        UserDefaults.standard.redirectURI = redirectURI
    }
}
