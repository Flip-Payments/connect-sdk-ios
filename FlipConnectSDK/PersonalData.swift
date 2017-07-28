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
    
    private let dateFormatter = DateFormatter()
    private let dateFormat = "yyyy-MM-dd"
    
    init?(json: JSON) {
        dateFormatter.dateFormat = dateFormat
        
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
        
        if self.isEntityNull() { return nil }
    }
    
    public init?(birthdate: Date? = nil,
         genderType: GenderType? = nil,
         country: String? = nil,
         dependentCount: Int? = nil) {
        
        dateFormatter.dateFormat = self.dateFormat
        
        self.birthdate = birthdate
        self.genderType = genderType
        self.country = country
        self.dependentCount = dependentCount
        
        if self.isEntityNull() { return nil }
    }
    
    private func isEntityNull() -> Bool {
        if birthdate == nil,
            genderType == nil,
            genderTypeFriendlyName == nil,
            country == nil,
            dependentCount == nil {
            
            return true
        }
        return false
    }
    
    static func getCountryName(countryCode: String?) -> String? {
        let countries = NSLocale.locales()
        let country = countries.first { $0.countryCode.uppercased() == countryCode?.uppercased() }
        return country?.countryName
    }
    
    static func getCountryCode(countryName: String?) -> String? {
        let countries = NSLocale.locales()
        let country = countries.first { $0.countryName.uppercased() == countryName?.uppercased() }
        return country?.countryCode
    }
    
    func toDictionary() -> JSON {
        var birthdateString: String? = nil
        if let birthdate = self.birthdate {
            birthdateString = self.dateFormatter.string(from: birthdate)
        }
        
        return [
            "birthdate": birthdateString as Any,
            "genderType": self.genderType?.rawValue as Any,
            "dependentCount": self.dependentCount as Any,
            "country": self.country as Any
        ]
    }
}

public enum GenderType: String {
    case masculine
    case feminine
    case unmentioned
}
