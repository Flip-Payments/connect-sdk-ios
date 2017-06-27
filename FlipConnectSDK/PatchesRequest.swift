//
//  PatchesRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Patch {
    var op: Operation
    
    private var _path: String
    var path: String {
        get {
            return _path
        }
        set {
            _path = "/\(newValue)"
        }
    }
    
    var value: Any
}

struct Patches {
    var patches: [Patch]
}

enum Operation {
    case replace
    case remove
}
