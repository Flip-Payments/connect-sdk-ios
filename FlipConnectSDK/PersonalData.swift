//
//  PersonalData.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 14/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct PersonalData {
    public private(set) var birthdate: Date? = nil
    public private(set) var genderType: GenderType? = nil
    public private(set) var genderTypeFriendlyName: String? = nil
    public private(set) var country: String? = nil
    public private(set) var dependentCount: Int? = nil
    
    init?(json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.country = json["country"] as? String
        self.genderTypeFriendlyName = json["genderTypeFriendlyName"] as? String
        self.dependentCount = json["dependentCount"] as? Int
        if let genderType = json["genderType"] as? String {
            self.genderType = GenderType(rawValue: genderType)
        }
        if let birthdate = json["birthdate"] as? String {
            let date = dateFormatter.date(from: birthdate)
            self.birthdate = date
        }
        
        if birthdate == nil, genderType == nil, genderTypeFriendlyName == nil, country == nil, dependentCount == nil {
            return nil
        }
    }
}

public enum GenderType: String {
    case masculine
    case feminine
    case unmentioned
}
