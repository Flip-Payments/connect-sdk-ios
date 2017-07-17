//
//  NSLocaleExtension.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 17/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension NSLocale {
    struct Locale {
        let countryCode: String
        let countryName: String
    }
    
    class func locales() -> [Locale] {
        
        var locales = [Locale]()
        for localeCode in NSLocale.isoCountryCodes {
            let countryName = NSLocale.systemLocale.displayNameForKey(NSLocaleCountryCode, value: localeCode)!
            let countryCode = localeCode
            let locale = Locale(countryCode: countryCode, countryName: countryName)
            locales.append(locale)
        }
        
        return locales
    }
}
