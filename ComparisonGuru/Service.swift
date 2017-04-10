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
import Alamofire

let baseUrl = "https://cguru-quasar6.rhcloud.com/"
let productPriceUrl = "cheapest"
let trendUrl = "products"
let commentUrl = "products/review"

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
    
    func postComment(parameters: JSON, completion:@escaping (Error?)->()){
        let request: APIRequest<String,JSONError> = tron.request(commentUrl)
        request.method = .post
        request.parameters = parameters.dictionaryObject!
        request.perform(withSuccess: { (info) in
            print("info: \(info)")
            completion(nil)
        }) { (error) in
            print("error: \(error)")
            completion(error)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}


class HomeDatasource: JSONDecodable {
    
    let products:[Product]
    
    required init(json: JSON) throws {
        guard let array = json.array else {
            throw NSError(domain: "com.quasar", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing JSON was not valid."])
        }
        self.products = array.map({Product(json:$0)})
    }
}

