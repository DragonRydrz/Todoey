//
//  File.swift
//  Todoey
//
//  Created by AJ Genung on 12/23/19.
//  Copyright © 2019 AJ Genung. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
