//
//  PatchesRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class Patch {
    var op: Operation
    
    var path: String
    
    var value: String?
    
    init(_ operation: Operation, _ path: String, _ value: String? = nil) {
        self.op = operation
        self.path = path
        self.value = value
    }
    
    func createDictionary() -> JSON {
        return [
            "op": self.op.rawValue,
            "path": self.path,
            "value": self.value as Any
        ]
    }
}

class Patches {
    var publicProfile: PublicProfilePatchRequest? = nil
    var personalData: PersonalDataPatchRequest? = nil
    
    
    func createDictionary() -> JSON {
        return [
            "publicProfile": self.publicProfile?.createDictionary() as Any,
            "personalData": self.personalData?.createDictionary() as Any
        ]
    }
}

enum Operation: String {
    case replace
    case remove
}
