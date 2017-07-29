//
//  SerializationUtil.swift
//  StonePortal
//
//  Created by Tatiana Magdalena on 11/1/16.
//  Copyright © 2016 Stone Pagamentos. All rights reserved.
//

import Foundation

struct SerializationHelper {
    
    static func composeJSONDataFrom(dictionary: Dictionary<String, Any>) -> Data? {
        
        if JSONSerialization.isValidJSONObject(dictionary) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                return jsonData
            }
            catch {
                return nil
            }
        }
        return nil
    }
    
    static func composeJSONStringFrom(dictionary: Dictionary<String, Any>, prettify: Bool = false) -> String? {
        
        if JSONSerialization.isValidJSONObject(dictionary) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: prettify ? .prettyPrinted : [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    let jaison = jsonString.replacingOccurrences(of: "\\/", with: "/")
                    return jaison
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
