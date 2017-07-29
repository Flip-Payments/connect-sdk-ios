//
//  TemporaryProfile.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 28/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

@objc
public class TemporaryProfile: NSObject {
    public var personalData: PersonalData? = nil
    public var vehicles: [Vehicle]? = nil
    public var addresses: [Address]? = nil
    public var phones: [Phone]? = nil
    public var documents: [Document]? = nil
    
    func toDictionary() -> JSON {
        var vehiclesJSON: [JSON]? = nil
        if let vehicles = self.vehicles {
            vehiclesJSON = []
            vehicles.forEach { vehicle in
                vehiclesJSON!.append(vehicle.toDictionary())
            }
        }
        
        var addressesJSON: [JSON]? = nil
        if let addresses = self.addresses {
            addressesJSON = []
            addresses.forEach { address in
                addressesJSON!.append(address.toDictionary())
            }
        }
        
        var phonesJSON: [JSON]? = nil
        if let phones = self.phones {
            phonesJSON = []
            phones.forEach { phone in
                phonesJSON!.append(phone.toDictionary())
            }
        }
        
        var documentsJSON: [JSON]? = nil
        if let documents = self.documents {
            documentsJSON = []
            documents.forEach { document in
                documentsJSON!.append(document.toDictionary())
            }
        }
        
        return [
            "personalData": self.personalData?.toDictionary() as Any,
            "vehicles": vehiclesJSON as Any,
            "addresses": addressesJSON as Any,
            "phones": phonesJSON as Any,
            "documents": documentsJSON as Any
        ]
    }
}
