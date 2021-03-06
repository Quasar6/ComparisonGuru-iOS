//
//  OtherProductsCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-18.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class OtherProductsCell: UICollectionViewCell {
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
        lbl.font = .systemFont(ofSize: 10)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let priceTagLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "CAD 399"
        lbl.font = .boldSystemFont(ofSize: 11)
        
        return lbl
    }()
    
    let storeImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "walmart"))
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
        self.clipsToBounds = true
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
    
    var product:Product!{
        didSet{
            updateData()
        }
    }
    
    fileprivate func updateData(){
        productImageView.loadImageUsingUrlString(urlString: product.imageUrl)
        productTitleLabel.text = product.name
        if product.salePrice == 0{
            priceTagLabel.text = "\(product.price)"
        } else {
            priceTagLabel.text = "\(product.salePrice)"
        }
        
        storeImageView.image = Helper.getStoreImageFromName(store: product.store)
        
    }
    
    fileprivate func setupViews(){
        addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(productTitleLabel)
        productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 2).isActive = true
        productTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(storeImageView)
        storeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        storeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        storeImageView.widthAnchor.constraint(equalToConstant: self.frame.width - 32).isActive = true
        storeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        addSubview(priceTagLabel)
        priceTagLabel.bottomAnchor.constraint(equalTo: storeImageView.topAnchor, constant: -4).isActive = true
        priceTagLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
