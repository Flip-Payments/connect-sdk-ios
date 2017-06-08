//
//  FCApi.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct FCApi {
    static func request(toURL url: URL, withVerb httpMethod: HTTPVerb = .get, withParameters parameters: Parameters? = nil, withHeaders headers: Headers? = nil, withBody body: JSON? = nil, completion: @escaping (_ response: [JSON]) -> Void) {
        var url = url
        
        if let prmtrs = parameters {
            url = mountRequestURL(url, withParameters: prmtrs)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
//        let postString = "id=13&name=Jack"
//        
//        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            let fodase: JSON = [
                "sua mae": "me ama"
            ]
            completion([fodase])
        }
        task.resume()
    }
    
    private static func mountRequestURL(_ url: URL, withParameters parameters: Parameters) -> URL {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        var queryItems = urlComponents.queryItems ?? []
        
        for (key, value) in parameters {
            let queryItem =  URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}
