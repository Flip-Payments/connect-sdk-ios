//
//  TemporaryProfileRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 28/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct TemporaryProfileRequest {
    var clientID: String? = nil
    
    var data: TemporaryProfile? = nil
    
    func toDictionary() -> JSON {
        return [
            "applicationKey": self.clientID as Any,
            "data": self.data?.toDictionary() as Any
        ]
    }
}
