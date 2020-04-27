//
//  ErrorModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 11.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

struct ErrorModel: Decodable {
    var key: String?
    var message: String?
}
