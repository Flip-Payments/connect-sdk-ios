//
//  DocumentsResponse.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 04/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct Documents: Response {
    var operationReport: [Report] = []
    
    var success: Bool = false
    
    var documents: [Document] = []
    
    init(json: JSON) {
        self.initializeResponse(json: json)
        
        guard let documents = json["documents"] as? [JSON] else {
            return
        }
        
        let document = documents.flatMap{ Document(json: $0) }
        
        self.documents = document
    }
}
