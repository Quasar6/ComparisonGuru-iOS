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

struct Service {
    let tron = TRON(baseURL: "https://cguru-quasar6.rhcloud.com/cheapest/")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(productName:String, completion:@escaping (HomeDatasource?, Error?)->()){
        //start json fetch
        let request: APIRequest<HomeDatasource,JSONError> = tron.request(productName)
        request.perform(withSuccess: { (homeDatasource) in
            print("Successfully fetched json objects")
            completion(homeDatasource, nil)
        }) { (err) in
            completion(nil, err)
            print("Failed to fetch json")
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
//        print(json)
        self.products = array.map({Product(json:$0)})
    }
}

