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
    public init(clientID: String, clientSecret: String, redirectURI: String, fingerPrintID: String? = nil) {
        self.fingerPrintID = fingerPrintID
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
    
    /// Used to send information to antifraud
    public var fingerPrintID: String?
    
    /// Your ClientID
    public var clientID: String
    
    /// Your Client Secret
    public var clientSecret: String
    
    /// The desired redirect URI (example: some://example)
    public var redirectURI: String
}
