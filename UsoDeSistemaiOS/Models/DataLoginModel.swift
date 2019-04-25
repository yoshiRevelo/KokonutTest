//
//  DataLoginModel.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import Foundation

class DataLoginModel: Codable {
    var token_type: String?
    var expires_in: Int?
    var access_token: String?
    var refresh_token: String?
}
