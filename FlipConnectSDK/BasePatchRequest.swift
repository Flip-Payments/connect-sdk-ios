//
//  BasePatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 26/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class BasePatchRequest {
    var patches: [Patch]? = nil
    
    var key: String? = nil
    
    func createDictionary() -> JSON {
        if let patches = patches {
            var patchesDicts: [JSON] = []
            
            for patch in patches {
                patchesDicts.append(patch.createDictionary())
            }
            return [
                "key": key as Any,
                "patches": patchesDicts
            ]
        }
        return [:]
    }
}
