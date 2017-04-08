//
//  Constants.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

struct Color {
    static let menuBarTintColor = UIColor(r: 213, g: 3, b: 0)
    static let statusBarBackgroundColor = UIColor(r: 213, g: 3, b: 0)
    static let searchFieldBorderColor = UIColor(r: 3, g: 184, b: 250)
    static let separatorColor = UIColor(r: 220, g: 220, b: 220)
}

struct Font {
    static let helveticaNeueBold = "HelveticaNeue-Bold"
}

struct Helper {
    static func getStoreImageFromName(store:String) -> UIImage {
        switch store {
        case "bestbuy":
            return #imageLiteral(resourceName: "bestbuy")
        case "ebay":
            return #imageLiteral(resourceName: "ebay")
        case "walmart":
            return #imageLiteral(resourceName: "walmart")
        default:
            return #imageLiteral(resourceName: "walmart")
        }
    }
}
