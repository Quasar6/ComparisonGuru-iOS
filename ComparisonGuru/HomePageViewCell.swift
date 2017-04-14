//
//  HomePageViewCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-06.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class HomePageViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var priceTagLabel: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    
//    override func awakeFromNib() {
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .white
        setupCellShaow()
    }
    
    var trendingProduct: Product? {
        didSet{
            updateProduct()
        }
    }
    
    private func updateProduct() {
        guard let trendingProduct = trendingProduct else{return}
        productTitleLabel.text = trendingProduct.name
        let price = trendingProduct.salePrice == 0 ? trendingProduct.price : trendingProduct.salePrice
        priceTagLabel.text = "\(trendingProduct.currency) \(price)"
        storeImageView.image = Helper.getStoreImageFromName(store: trendingProduct.store)
        productImageView.loadImageUsingUrlString(urlString: trendingProduct.imageUrl)
    }
    
    private func setupCellShaow() {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
//        self.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath  //safe system resource by providing this
        
//        self.layer.shouldRasterize = true // ask iOS to cache the rendered shadow again, safe system resource
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.7
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = false

    }
}
