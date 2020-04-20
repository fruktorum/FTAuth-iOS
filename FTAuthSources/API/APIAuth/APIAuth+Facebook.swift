//
//  APIAuth+Facebook.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

//import Foundation
//
//extension APIAuth.Facebook: APIResponse {
//    
//    var path: String {
//        switch self {
//        case .auth:
//            return "\(AUTH_SERVER_URL)/facebook/auth"
//        }
//    }
//    
//    var request: APIRequest {
//        return APIRequest.createRequest(
//            url: path,
//            httpMethod: .post,
//            body: body)
//    }
//    
//    var body: [String: AnyObject] {
//        switch self {
//        case .auth(let fbToken):
//            return [
//                "access_token": fbToken
//            ] as [String: AnyObject]
//        default:
//            return [:]
//        }
//    }
//}



