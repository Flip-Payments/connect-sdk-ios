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
    
    private var path: String
    
    var value: String?
    
    init(_ operation: Operation, _ path: String, _ value: String? = nil) {
        self.op = operation
        self.path = path
        self.value = value
    }
}

class Patches {
    var publicProfile: PublicProfilePatchRequest = PublicProfilePatchRequest()
}

enum Operation {
    case replace
    case remove
}
