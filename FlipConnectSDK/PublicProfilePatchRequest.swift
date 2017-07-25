//
//  PublicProfilePatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class PublicProfilePatchRequest {
    var patches: [Patch]? = nil
    
    func add(operation: Operation, path: PublicProfilePathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
}

enum PublicProfilePathEnum: String {
    case name = "/name"
    case pictureUrl = "/pictureUrl"
}
