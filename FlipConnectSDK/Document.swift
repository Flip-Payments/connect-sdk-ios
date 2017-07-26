//
//  Document.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct Document {
    public private(set) var key: String
    public private(set) var type: DocumentType
    public private(set) var typeFriendlyName: String
    public private(set) var number: String
    public private(set) var data: JSON?
    
    init?(json: JSON) {
        guard let key = json["key"] as? String,
            let type = DocumentType(rawValue: (json["documentType"] as? String)!),
            let typeFriendlyName = json["documentTypeFriendlyName"] as? String,
            let number = json["documentNumber"] as? String
            else {
                return nil
        }
        
        self.key = key
        self.type = type
        self.typeFriendlyName = typeFriendlyName
        self.number = number
        self.data = json["documentData"] as? JSON
    }
}

public enum DocumentType: String {
    case cpf
    case cnpj
    case cnh
    case passport
}
