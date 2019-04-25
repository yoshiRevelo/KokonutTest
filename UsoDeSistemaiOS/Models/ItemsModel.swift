//
//  ItemsModel.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//

import Foundation

class ItemsModel: Codable {
    var id_post: Int?
    var title: String?
    var body: String?
    var slug: String?
    var created_at: String?
    var header: String?
    var footer: String?
    var image_url: String?
    var updated_at: String?
}
