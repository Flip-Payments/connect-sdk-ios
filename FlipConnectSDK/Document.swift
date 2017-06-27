//
//  Document.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Document {
    var id: Int
    var type: DocumentType
    var typeFriendlyName: String
    var number: String
    var data: JSON?
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let type = DocumentType(rawValue: (json["documentType"] as? String)!),
            let typeFriendlyName = json["documentTypeFriendlyName"] as? String,
            let number = json["documentNumber"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.type = type
        self.typeFriendlyName = typeFriendlyName
        self.number = number
        self.data = json["documentData"] as? JSON
    }
}

enum DocumentType: String {
    case cpf
    case cnpj
    case cnh
    case passport
}
