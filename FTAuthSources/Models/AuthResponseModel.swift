//
//  AuthResponseModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 11.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

class AuthResponseModel: Decodable {
    var success: Bool?
    var errors: [FTErrorModel]?//ErrorType?
    var provider_token: String?
    var session_token: String?
}


class ResponseModel: Decodable {
    var success: Bool?
    var errors: ErrorType?//String?
}
