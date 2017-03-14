//
//  Product.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-11.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Product {
    
    let id: String
    let name: String
    let category: String
    let price: Double
    let salePrice: Double
    let store: String
    let currency: String
    let url: String
    let imageUrl: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.category = json["category"].stringValue
        self.price = json["price"].doubleValue
        self.salePrice = json["salePrice"].doubleValue
        self.store = json["store"].stringValue
        self.currency = json["currency"].stringValue
        self.url = json["url"].stringValue
        self.imageUrl = json["imageURL"].stringValue
    }
}
