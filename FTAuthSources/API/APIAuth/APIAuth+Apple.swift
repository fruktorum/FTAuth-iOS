//
//  APIAuth+Apple.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 16.04.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import Foundation

extension APIAuth.Apple: APIResponse {

    var path: String {
        switch self {
        case .auth:
            return "\(AUTH_SERVER_URL)/apple/auth"
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
        case .auth(let identityToken):
            return [
                "identity_token": identityToken
            ] as [String: AnyObject]
        default:
            return [:]
        }
    }
}
