//
//  PublicProfilePatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class PublicProfilePatchRequest: BasePatchRequest, PatchRequestProtocol {
    
    func add(operation: Operation, path: PublicProfilePathEnum, value: String? = nil) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        if patches!.contains(where: { $0.path == path.rawValue && $0.op == operation }) {
            patches!.forEach { patch in
                if patch.path == path.rawValue, patch.op == operation {
                    patch.value = value
                }
            }
        } else {
            patches!.append(patch)
        }
    }
}

enum PublicProfilePathEnum: String {
    case name = "/name"
    case pictureUrl = "/pictureUrl"
}
