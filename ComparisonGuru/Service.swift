//
//  Service.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-11.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

let baseUrl = "https://cguru-quasar6.rhcloud.com/"
let productPriceUrl = "cheapest"
let trendUrl = "products"

struct Service {
    let tron = TRON(baseURL: baseUrl)
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(productName:String, completion:@escaping (HomeDatasource?, Error?)->()){
        print(productPriceUrl)
        //start json fetch
        let request: APIRequest<HomeDatasource,JSONError> = tron.request("cheapest/\(productName)")
        request.perform(withSuccess: { (homeDatasource) in
            print("Successfully fetched json objects")
            completion(homeDatasource, nil)
        }) { (err) in
            completion(nil, err)
            print("Failed to fetch json")
        }
    }
    
    func fetchFrequentSearchedProduct(completion: @escaping (HomeDatasource?, Error?)->()){
        let request: APIRequest<HomeDatasource,JSONError> = tron.request(trendUrl)
        request.perform(withSuccess: { (trendDataSource) in
            print("Successfully fetched json objects from fetchFrequentSearchedProduct")
            completion(trendDataSource, nil)
        }) { (err) in
            completion(nil,err)
            print("Failed to fetch json from frequentSearch product")
        }
        
        
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}

//class TrendDataSource: JSONDecodable {
//    let trendingProducts:[TrendingProduct]
//    
//    required init(json: JSON) throws {
//        guard let array = json.array else {
//            throw NSError(domain: "com.quasar", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing JSON was not valid."])
//        }
//        
//        self.trendingProducts = array.map{TrendingProduct(json: $0)}
//    }
//    
//}

class HomeDatasource: JSONDecodable {
    
    let products:[Product]
    
    required init(json: JSON) throws {
        guard let array = json.array else {
            throw NSError(domain: "com.quasar", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing JSON was not valid."])
        }
        self.products = array.map({Product(json:$0)})
    }
}

