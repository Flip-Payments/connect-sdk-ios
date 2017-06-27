//
//  AddressesResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Addresses: Response {
    var operationReport: [Report] = []

    var success: Bool = false

    var addresses: [Address] = []
    
    init?(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let addresses = json["addresses"] as? [JSON] else {
            return
        }
        
        // let a = addresses.flatMap{ Address(json: $0) } // another way
        
        let address = addresses.flatMap({ address in
            return Address(json: address)
        })
        
        self.addresses = address
        
        return nil
    }
}
