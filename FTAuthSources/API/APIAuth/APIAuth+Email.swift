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
            var payload = FTAuth.authPayload ?? [String: AnyObject]()
            payload["email"] = email as AnyObject
            payload["password"] = password as AnyObject
            return payload
        case .register(let email, let password, let name, let firstName, let lastName, let phone):
            var extraPayload = FTAuth.registrationPayload ?? [String: AnyObject]()
            extraPayload["name"] = name as AnyObject
            extraPayload["first_name"] = firstName as AnyObject
            extraPayload["last_name"] = lastName as AnyObject
            extraPayload["phone"] = phone as AnyObject
            
            var payload = [String: AnyObject]()
            payload["email"] = email as AnyObject
            payload["password"] = password as AnyObject
            payload["payload"] = extraPayload as AnyObject
            return payload
        }
    }
}
