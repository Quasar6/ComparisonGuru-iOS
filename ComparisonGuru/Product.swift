//
//  TrendingProduct.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-04.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    
    let _id: String
    let id: String
    let hits: Int
    var trends:[Trend]?
    let name: String
    let category: String
    let salePrice: Double
    let price: Double
    let store: String
    let currency: String
    let url: String
    let imageUrl: String
    let shippingCountry: String
    var reviews:[Review]?
    
    var triggeredHit:Bool = false
    
    init(json:JSON) {
        self._id = json["_id"].stringValue
        self.id = json["id"].stringValue
        self.hits = json["hits"].intValue
        self.name = json["name"].stringValue
        self.category = json["category"].stringValue
        self.price = json["price"].doubleValue
        self.salePrice = json["salePrice"].doubleValue
        self.store = json["store"].stringValue
        self.currency = json["currency"].stringValue
        self.url = json["url"].stringValue
        self.imageUrl = json["imageURL"].stringValue
        self.shippingCountry = json["shippingCountry"].stringValue
        
        if let trendArray = json["trend"].array {
            //use map to iterate through the json array
            self.trends = trendArray.map{Trend(json:$0)}
        }
        if let reviewsArray = json["reviews"].array {
            self.reviews = reviewsArray.map{Review(json:$0)}
        }
    }
    
    func toJSON() -> JSON {
        let json:JSON = [
            "id": id,
            "name":name,
            "category":category,
            "price": price,
            "salePrice": salePrice,
            "store": store,
            "currency": currency,
            "url": url,
            "imageURL": imageUrl,
            "shippingCountry": shippingCountry
        ]
        return json
    }
    
}

struct Review {
    var comment: String
    var rating: Int
    var date: String
    var userName: String
    var userImage: String
    
    init(json:JSON) {
        self.comment = json["comment"].stringValue
        self.rating = json["rating"].intValue
        self.date = json["date"].stringValue
        self.userName = json["userName"].stringValue
        self.userImage = json["userImage"].stringValue
    }
    
    func toJSON()-> JSON {
        return [
            "comment": comment,
            "rating": rating,
            "date": date,
            "userName": userName,
            "userImage": userImage
        ]
    }
}

struct Trend {
    let price: Double
    let date: String
    
    init(json:JSON) {
        self.price = json["price"].doubleValue
        self.date = json["date"].stringValue
    }
    
    func toJSON() -> JSON {
        return [
            "price":price,
            "date": date
        ]
    }
    
}
