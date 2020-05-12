//
//  AuthResponseModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 11.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

public class AuthResponseModel: ResponseModel {
    var provider_token: String?
    var session_token: String?
    
    init(_ session_token: String?, _ provider_token: String?) {
        super.init()
        self.session_token = session_token
        self.provider_token = provider_token
        self.success = true
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}


public class ResponseModel: Decodable {
    var success: Bool?
    var errors: [FTErrorModel]?
}
