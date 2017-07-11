//
//  AddressesResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct AddressesResponse: Response {
    public var operationReport: [Report] = []

    public var success: Bool = false

    public private(set) var addresses: [Address] = []
    
    public init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let addresses = json["addresses"] as? [JSON] else {
            return
        }
        
        // let a = addresses.flatMap{ Address(json: $0) } // another way
        
        let address = addresses.flatMap({ address in
            return Address(json: address)
        })
        
        self.addresses = address
    }
}
