//
//  APIAuth.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

extension API.Auth: APIResponse {
    
    var path: String {
        switch self {
        case .authorization:
            return "\(SERVER_URL)/auth"
        case .registration(_, _):
            return "\(SERVER_URL)/auth/sms"
        case .logout:
            return "\(SERVER_URL)/logout"
        }
    }
    
    var request: APIRequest {
        switch self {
        case .authorization:
            return APIRequest.createRequest(
                url: path,
                httpMethod: .post,
                body: body)
        case .registration:
            return APIRequest.createRequest(
                url: path,
                httpMethod: .post,
                body: body,
                header: APIHeader.setHeader())
        case .logout:
            return APIRequest.createRequest(
                url: path,
                httpMethod: .post,
                header: APIHeader.setHeader())
        }
    }
    
    var body: [String: AnyObject] {
        switch self {
        case .authorization(let email, let password):
            return [
                "email": email as AnyObject,
                "password": password as AnyObject
            ] as [String: AnyObject]
        case .registration(let email, let password):
            return [
                "email": email as AnyObject,
                "password": password as AnyObject
            ] as [String: AnyObject]
        default:
            return [:]
        }
    }
}
