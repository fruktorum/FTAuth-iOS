//
//  APIRequest.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

struct APIRequest {
    
    let url: String
    let httpMethod: String
    let body: [String: AnyObject]?
//    let imageData: [String: Data]?
    
//    static func createRequest(url: String, httpMethod: HTTPMethod, body: Data? = nil) -> APIRequest {
//        return self.init(url: url, httpMethod: httpMethod.rawValue, body: body)
//    }
    
//    static func createRequest(url: String, httpMethod: HTTPMethod, body: [String: AnyObject]? = nil, header: HTTPHeaders? = nil, imageData: [String: Data]? = nil) -> APIRequest {
//        return self.init(url: url, httpMethod: httpMethod, body: body, header: header, imageData: imageData)
//    }
    
    static func createRequest(url: String, httpMethod: HTTPMethod, body: [String: AnyObject]? = nil) -> APIRequest {
        return self.init(url: url, httpMethod: httpMethod.rawValue, body: body)
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
