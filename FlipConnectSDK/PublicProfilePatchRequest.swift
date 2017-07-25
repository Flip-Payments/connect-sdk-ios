//
//  PublicProfilePatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct PublicProfilePatchRequest {
    var patches: Patches = []
    
    mutating func add(operation: Operation, path: PublicProfilePathEnum, value: String) {
//        let patch = Patch(operation, path.rawValue, value)
//        patches.append(patch)
    }
}

enum PublicProfilePathEnum: String {
    case name
    case pictureUrl
}
