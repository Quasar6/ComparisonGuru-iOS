//
//  OverViewViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-16.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class OverViewViewController: UIViewController {

    let cellId = "cellId"
    
    var product:Product?{
        didSet{
//            overView.productNameLabel.text = product!.name
            overView.product = product
            
        }
    }
    var trendingProducts:[Product]?
    
    var collectionView:UICollectionView!
    
    lazy var overView:OverViewView = {
        let view = OverViewView()
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        collectionView = overView.relatedProductCollection
        overView.relatedProductCollection.delegate = self
        overView.relatedProductCollection.dataSource = self
        
        collectionView.register(OtherProductsCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    fileprivate func setupViews() {
        view.addSubview(overView)
        overView.fillSuperview()
    }
}

extension OverViewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OtherProductsCell
        if let trendingProducts = trendingProducts {
            cell.product = trendingProducts[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: collectionView.frame.height)
    }
}
