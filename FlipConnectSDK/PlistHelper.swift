//
//  PlistHelper.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct PlistHelper {
    private var clientID: String
    
    init(bundle jsonArray: JSON?) throws {
        guard let plist = jsonArray else {
            throw FCErrors.plistNotFound
        }
        
        guard let config = plist["FlipConnectSDK"] as? [JSON], !config.isEmpty else {
            throw FCErrors.configNotFound
        }
        
        var idClient = ""
        for item in config {
            guard let clientID = item["ClientID"] as? String else {
                throw FCErrors.incorrectIdentifier
            }
            
            idClient = clientID
        }
        
        self.clientID = idClient.lowercased()
        UserDefaults.standard.clientID = self.clientID
    }
}
