//
//  DetailView.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class OverViewView: UIView {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        return sv
    }()
    
    let childContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "phone")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let separatorUnderImage:UIView = {
        let v = UIView()
        v.backgroundColor = Color.separatorColor
        return v
    }()
    
    lazy var productNameLabel:UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
//        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "LifeProof - Frē Protective Waterproof Case for Apple® iPhone® 7 Plus - Asphalt black  Plus - Asphalt black rē Protective Waterproof Case for Apple® iPhone® 7 Plus - Asphalt black  Plus - Asphalt black"
        return label
    }()
    
    let separatorUnderNameLabel: UIView = {
        let v = UIView()
        v.backgroundColor = Color.separatorColor
        return v
    }()
    
    let priceTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "Best Price"
        return label
    }()
    
    let priceTagLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .blue
        label.text = "CAD 399"
        return label
    }()
    
    let collectionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "OTHER PRODUCTS"
        return label
    }()
    
    let relatedProductCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    var product:Product?{
        didSet{
            updateProduct()
        }
    }
    
    private func updateProduct() {
        guard let product = self.product else {return}
        productNameLabel.text = product.name
        var price = product.salePrice
        if price == 0 {
            price = product.price
        }
        priceTagLabel.text = "\(product.currency) \(price)"
        imageView.loadImageUsingUrlString(urlString: product.imageUrl)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(scrollView)
        scrollView.fillSuperview()
        
        childContentView.addSubview(imageView)
        imageView.anchor(childContentView.topAnchor, left: childContentView.leftAnchor, bottom: nil, right: childContentView.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 160)
        imageView.anchorCenterXToSuperview()
        
        childContentView.addSubview(separatorUnderImage)
        separatorUnderImage.anchor(imageView.bottomAnchor, left: childContentView.leftAnchor, bottom: nil, right: childContentView.rightAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 1)
        
        adjustProductLabelFrame()
        childContentView.addSubview(productNameLabel)
        productNameLabel.anchor(separatorUnderImage.bottomAnchor, left: separatorUnderImage.leftAnchor, bottom: nil, right: separatorUnderImage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: productNameLabel.frame.height)
        
        childContentView.addSubview(separatorUnderNameLabel)
        separatorUnderNameLabel.anchor(productNameLabel.bottomAnchor, left: separatorUnderImage.leftAnchor, bottom: nil, right: separatorUnderImage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        childContentView.addSubview(priceTitle)
        priceTitle.anchor(separatorUnderNameLabel.bottomAnchor, left: productNameLabel.leftAnchor, bottom: nil, right: productNameLabel.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        childContentView.addSubview(priceTagLabel)
        priceTagLabel.anchor(priceTitle.bottomAnchor, left: priceTitle.leftAnchor, bottom: nil, right: priceTitle.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        childContentView.addSubview(collectionTitle)
        collectionTitle.anchor(priceTagLabel.bottomAnchor, left: priceTagLabel.leftAnchor, bottom: nil, right: priceTagLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        childContentView.addSubview(relatedProductCollection)
        relatedProductCollection.anchor(collectionTitle.bottomAnchor, left: childContentView.leftAnchor, bottom: childContentView.bottomAnchor, right: childContentView.rightAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 160)
        
        scrollView.addSubview(childContentView)
        childContentView.fillSuperview()
        childContentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true

        
        
        
        
    }
    
    //MARK: - adjust the textview frame size depending on the contents length before add constrain to it
    private func adjustProductLabelFrame() {
        let contentSize = self.productNameLabel.sizeThatFits(self.productNameLabel.bounds.size)
        var frame = self.productNameLabel.frame
        frame.size.height = contentSize.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
