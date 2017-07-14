//
//  User.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 05/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct User {
    public private(set) var accountKey: String
    public private(set) var isEnabled: Bool
    public private(set) var membershipCreateDate: Date?
    public private(set) var isNewsLetterAllowed: Bool?
    public private(set) var publicProfile: PublicProfile?
    public private(set) var emails: [Email] = []
    public private(set) var phones: [Phone] = []
    
    init?(json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy h:mm:ss a"
        
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
        if let membershipCreateDateString = json["membershipCreateDate"] as? String {
            let membershipCreateDate = dateFormatter.date(from: membershipCreateDateString)
            self.membershipCreateDate = membershipCreateDate
        }
        if let isNewsLetterAllowed = json["isNewsLetterAllowed"] as? Bool {
            self.isNewsLetterAllowed = isNewsLetterAllowed
        }
        if let emailsJSON = json["emails"] as? [JSON] {
            let emails = emailsJSON.flatMap{ Email(json: $0) }
            self.emails = emails
        }
        if let phonesJSON = json["phones"] as? [JSON] {
            let phones = phonesJSON.flatMap{ Phone(json: $0) }
            self.phones = phones
        }
    }
}
