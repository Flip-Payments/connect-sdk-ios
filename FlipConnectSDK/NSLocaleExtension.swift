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
            let currentLocale = NSLocale.current as NSLocale
            let countryName = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)!
            let countryCode = localeCode
            let locale = Locale(countryCode: countryCode, countryName: countryName)
            locales.append(locale)
        }
        
        return locales
    }
    
    func counrtyNames() -> NSArray{
        
        let countryCodes = NSLocale.isoCountryCodes
        let countries: NSMutableArray = NSMutableArray()
        
        for countryCode in countryCodes{
            //            let dictionary: NSDictionary = NSDictionary(object:countryCode, forKey:NSLocale.Key.countryCode as NSCopying)
            
            //get identifire of the counrty
            //            var identifier: NSString? = NSLocale.localeIdentifier(fromComponents: dictionary as! [String : String]) as NSString
            
            let locale = NSLocale.current as NSLocale
            //get country name
            let country = locale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)//replace "NSLocaleIdentifier"  with "NSLocaleCountryCode" to get language name
            
            if country != nil {//check the country name is  not
                countries.add(country!)
            }
        }
        NSLog("\(countries)")
        return countries
    }
}
