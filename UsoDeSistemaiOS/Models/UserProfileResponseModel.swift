//
//  UserProfileResponseModel.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import Foundation

class UserProfileResponseModel: Codable{
    var success: Int?
    var message: String?
    var data: UserDataModel?
}
