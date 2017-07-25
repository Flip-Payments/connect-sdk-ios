//
//  PersonalDataPatchRequest.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 25/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

class PersonalDataPatchRequest: PatchRequestProtocol {
    var patches: [Patch]? = nil    
    
    func add(operation: Operation, path: PersonalDataPathEnum, value: String?) {
        if patches == nil {
            patches = []
        }
        
        let patch = Patch(operation, path.rawValue, value)
        patches!.append(patch)
    }
    
    func createDictionary() -> JSON {
        if let patches = patches {
            var patchesDicts: [JSON] = []
            
            for patch in patches {
                patchesDicts.append(patch.createDictionary())
            }
            return [
                "patches": patchesDicts
            ]
        }
        return [:]
    }
}

enum PersonalDataPathEnum: String {
    case birthdate = "/birthdate"
    case genderType = "/type"
    case dependentCount = "/dependentCount"
    case country = "/country"
}
