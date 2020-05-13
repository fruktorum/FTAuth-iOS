//
//  APIAuth+Logout.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

extension APIAuth.Session: APIResponse {
    
    var request: APIRequest {
        switch self {
        case .logout(let header):
            return APIRequest.createRequest(
            url: path,
            httpMethod: .post,
            header: header)
        }
    }

    var path: String {
        switch self {
        case .logout:
            return "\(AUTH_SERVER_URL)/session/logout"
        }
    }
}
