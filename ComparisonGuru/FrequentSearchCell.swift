//
//  FrequentSearchCellCollectionViewCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class FrequentSearchCell: UICollectionViewCell {
    
    let productImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "googlepixel"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let productTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "Google Pixel"
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let priceTagLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "CAD 399"
        lbl.font = .boldSystemFont(ofSize: 16)
        
        return lbl
    }()
    
    let storeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellShadow()
        setupViews()
        backgroundColor = .white
    }
    
    var trendingProduct: Product? {
        didSet{
            updateProduct()
        }
    }
    
    fileprivate func updateProduct() {
        guard let trendingProduct = trendingProduct else{return}
        productTitleLabel.text = trendingProduct.name
        priceTagLabel.text = "\(trendingProduct.currency) \(trendingProduct.price)"
        storeImageView.image = Helper.getStoreImageFromName(store: trendingProduct.store)
    }
    
    fileprivate func setupCellShadow(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath  //safe system resource by providing this
        
        self.layer.shouldRasterize = true // ask iOS to cache the rendered shadow again, safe system resource
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(r: 183, g: 183, b: 183).cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        
    }
    
    fileprivate func setupViews(){
        addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(productTitleLabel)
        productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4).isActive = true
        productTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        productTitleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.9).isActive = true
        productTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(storeImageView)
        storeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        storeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        storeImageView.widthAnchor.constraint(equalToConstant: self.frame.width - 32).isActive = true
        storeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        addSubview(priceTagLabel)
        priceTagLabel.bottomAnchor.constraint(equalTo: storeImageView.topAnchor, constant: -8).isActive = true
        priceTagLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        priceTagLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
