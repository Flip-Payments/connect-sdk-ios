//
//  File.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

protocol PatchRequestProtocol {
    associatedtype EnumType
    
    func add(operation: Operation, path: EnumType, value: String?)
}

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
