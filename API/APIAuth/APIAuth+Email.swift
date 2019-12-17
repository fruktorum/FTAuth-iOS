//
//  APIAuth+Email.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

extension APIAuth.Email: APIResponse {

    var path: String {
        switch self {
        case .auth:
            return "\(AUTH_SERVER_URL)/email/auth"
        case .register:
            return "\(AUTH_SERVER_URL)/email/register"
        }
    }

    var request: APIRequest {
        return APIRequest.createRequest(
            url: path,
            httpMethod: .post,
            body: body)
    }
    
    var body: [String: AnyObject] {
        switch self {
        case .auth(let email, let password):
            return [
                "email": email as AnyObject,
                "password": password as AnyObject
            ] as [String: AnyObject]
        case .register(let email, let password, let name, let phone):
            return [
                "email": email as AnyObject,
                "password": password as AnyObject,
                "payload": [
                    "full_name": name as AnyObject,
                    "phone": phone as AnyObject
                    ] as AnyObject
            ] as [String: AnyObject]
        }
    }
}
