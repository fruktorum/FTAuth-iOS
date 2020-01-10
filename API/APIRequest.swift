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
    let header: String?
    
    static func createRequest(url: String, httpMethod: HTTPMethod, body: [String: AnyObject]? = nil, header: String? = nil) -> APIRequest {
        return self.init(url: url, httpMethod: httpMethod.rawValue, body: body, header: header)
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
