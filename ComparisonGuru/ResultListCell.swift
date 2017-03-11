//
//  ResultListCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-10.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class ResultListCell: UITableViewCell {

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "googlepixel")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.text = "Google Pixel Screen Protector, Spigen@[Tempered Glass] [2 Pack]"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    let storeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "walmart")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "USD 19.99"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productName)
        contentView.addSubview(storeImage)
        contentView.addSubview(priceLabel)
        //x,y,w,h
        productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
//        productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //x,y,w,h
        productName.topAnchor.constraint(equalTo: productImageView.topAnchor).isActive = true
        productName.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8).isActive = true
        productName.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        //x,y,w,h
        storeImage.leftAnchor.constraint(equalTo: productName.leftAnchor).isActive = true
        storeImage.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 2).isActive = true
        storeImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        storeImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //x,y,w,h
        priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: storeImage.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
