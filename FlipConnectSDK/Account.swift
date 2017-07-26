//
//  Account.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Account {
    public private(set) var accountKey: String
    public private(set) var isEnabled: Bool
    public private(set) var publicProfile: PublicProfile?
    public private(set) var personalData: PersonalData?
    public private(set) var emails: [Email] = []
    public private(set) var phones: [Phone] = []
    public private(set) var addresses: [Address] = []
    public private(set) var documents: [Document] = []
    
    init?(json: JSON) {
       
        guard let accountKey = json["accountKey"] as? String,
            let isEnabled = json["isEnabled"] as? Bool
            else {
                return nil
        }
        
        self.accountKey = accountKey
        self.isEnabled = isEnabled
        self.publicProfile = nil
        if let publicProfileJSON = json["publicProfile"] as? JSON {
            self.publicProfile = PublicProfile(json: publicProfileJSON)
        }
        if let personalDataJSON = json["personalData"] as? JSON {
            self.personalData = PersonalData(json: personalDataJSON)
        }
        if let emailsJSON = json["emails"] as? [JSON] {
            let emails = emailsJSON.flatMap{ Email(json: $0) }
            self.emails = emails
        }
        if let phonesJSON = json["phones"] as? [JSON] {
            let phones = phonesJSON.flatMap{ Phone(json: $0) }
            self.phones = phones
        }
        if let addressesJSON = json["addresses"] as? [JSON] {
            let addresses = addressesJSON.flatMap { Address(json: $0) }
            self.addresses = addresses
        }
        if let documentsJSON = json["documents"] as? [JSON] {
            let documents = documentsJSON.flatMap { Document(json: $0) }
            self.documents = documents
        }
    }
}
