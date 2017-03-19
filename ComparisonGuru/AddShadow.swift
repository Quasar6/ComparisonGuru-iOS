//
//  AddShadow.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-18.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath  //safe system resource by providing this
        
        self.layer.shouldRasterize = true // ask iOS to cache the rendered shadow again, safe system resource
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
    
}

