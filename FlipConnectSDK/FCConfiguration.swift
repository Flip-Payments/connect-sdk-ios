//
//  FCConfiguration.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 01/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public class FCConfiguration {
    public init(apiToken: String, clientID: String, clientSecret: String, redirectURI: String, fingerPrintID: String? = nil) {
        self.fingerPrintID = fingerPrintID
        self.apiToken = apiToken
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
    
    public var fingerPrintID: String?
    
    public var apiToken: String
    
    public var clientID: String
    
    public var clientSecret: String
    
    public var redirectURI: String
}
