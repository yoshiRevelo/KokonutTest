//
//  ItemsDataModel.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import Foundation

class ItemsDataModel: Codable {
    var current_page: Int?
    var data: [ItemsModel]?
    var first_page_url: String?
    var from: Int?
    var last_page: Int?
    var last_page_url: String?
    var next_page_url: String?
    var path: String?
    var per_page: Int?
    var prev_page_url: String?
    var to: Int?
    var total: Int?
}
