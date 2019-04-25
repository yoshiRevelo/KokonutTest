//
//  Items+CoreDataProperties.swift
//  UsoDeSistemaiOS
//
//  Created by Yoshi Revelo on 4/24/19.
//  Copyright © 2019 Yoshi Revelo. All rights reserved.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var body: String?
    @NSManaged public var image: String?
    @NSManaged public var favorite: Bool

}
