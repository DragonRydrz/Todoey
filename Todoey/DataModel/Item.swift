//
//  Item.swift
//  Todoey
//
//  Created by AJ Genung on 12/23/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var complete: Bool = false
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
