//
//  FCConfiguration.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 01/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public class FCConfiguration {
    
    /**
     Initialize the necessary configurations to run the SDK
     
     - Parameters:
        - apiToken: Token received to use API
        - clientID: Your ClientID
        - clientSecret: Your Client Secret
        - redirectURI: The desired redirect URI (example: some://example)
        - fingerPrintID: Used to send information to antifraud
    **/
    public init(environment: FCEnvironmentEnum, clientID: String, clientSecret: String, redirectURI: String, fingerPrintID: String? = nil) {
        FCConfiguration.environment = environment
        FCConfiguration.fingerPrintID = fingerPrintID
        FCConfiguration.clientID = clientID
        FCConfiguration.clientSecret = clientSecret
        FCConfiguration.redirectURI = redirectURI
    }
    
    /// Used to send information to antifraud
    internal static var fingerPrintID: String?
    
    /// Your ClientID
    internal static var clientID: String = ""
    
    /// Your Client Secret
    internal static var clientSecret: String = ""
    
    /// The desired redirect URI (example: some://example)
    internal static var redirectURI: String = ""
    
    internal static var environment: FCEnvironmentEnum = .sandbox
    
    internal static var authorizationCode: String = ""
}
