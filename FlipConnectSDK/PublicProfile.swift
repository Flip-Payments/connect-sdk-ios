//
//  PublicProfile.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 05/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct PublicProfile {
    var name: String?
    var pictureURL: String?
    
    init?(json: JSON) {
        self.name = json["name"] as? String
        self.pictureURL = json["pictureUrl"] as? String
        
        if self.name == nil && self.pictureURL == nil {
            return nil
        }
    }

}
