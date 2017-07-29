//
//  FCApi.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public struct FCApi {
       
    static func request(toURL url: URL, withVerb httpMethod: HTTPVerb = .get, withParameters parameters: Parameters? = nil, withHeaders headers: Headers? = nil, withBody body: JSON? = nil, completion: @escaping (_ response: JSON, _ error: Error?) -> Void) {
        var url = url
        var errorResponse: Error? = nil
        
        if let prmtrs = parameters {
            url = mountRequestURL(url, withParameters: prmtrs)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let langCode = Locale.current.languageCode ?? "en"
        let regionCode = Locale.current.regionCode ?? "US"
        let lang = "\(langCode)-\(regionCode)"
        
        let internalHeaders: Headers = [
            "Accept-Language": lang,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        for (key, value) in internalHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            let data = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = data
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {         // check for fundamental networking error
                errorResponse = FCErrors.requestUnsuccessful(message: "There was an error with the request \(error.debugDescription))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode < 200, httpStatus.statusCode > 399 {           // check for http errors
                errorResponse = FCErrors.requestUnsuccessful(message: "StatusCode: \(httpStatus.statusCode) and response = \(String(describing: response))")
                return
            }
            
            var responseJSON = JSON()
            
            do {
                responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! JSON
            } catch {
                errorResponse = FCErrors.requestUnsuccessful(message: "Serialization failed: \(error.localizedDescription)")
            }
            
            completion(responseJSON, errorResponse)
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
