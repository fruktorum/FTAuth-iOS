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
            return APIRequest.createRequest(
                url: path,
                httpMethod: .post)//,
    //            body: body)
        }

    var path: String {
        switch self {
        case .logout:
            return "\(AUTH_SERVER_URL)/session/logout"
    }

//    var body: [String: AnyObject] {
//        switch self {
//        case .logout:
//            return [
//                "email": email as AnyObject,
//                "password": password as AnyObject
//            ] as [String: AnyObject]
//        }
    }
}
