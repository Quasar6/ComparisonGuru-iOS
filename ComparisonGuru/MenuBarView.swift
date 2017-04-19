//
//  MenuBarView.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class MenuBarView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "menuCellId"
    let titles = ["OVERVIEW", "TRENDING", "REVIEWS"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMenuBarCollectionView()
        
        self.addShadow()
    }
    
    func setupMenuBarCollectionView() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        //x,y,w,h
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupHorizontalBar()
    }
    
    var tappedAction: ((_ mIndex:Int) -> Void)?
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                let x = CGFloat(menuIndex) * frame.width / 3
                horizongtalBarLeftConstrain?.constant = x
        
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.layoutIfNeeded()
                }, completion: nil)
        tappedAction?(menuIndex)
    }
    
    var horizongtalBarLeftConstrain: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .orange
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        //        horizontalBarView x,y,w,h
        horizongtalBarLeftConstrain = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
        horizongtalBarLeftConstrain?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.title.text = titles[indexPath.item]
        if indexPath.item == 1 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        scrollToMenuIndex(menuIndex: indexPath.item)
//        let x = CGFloat(indexPath.item) * frame.width / 3
//        horizongtalBarLeftConstrain?.constant = x
//        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.layoutIfNeeded()
//        }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        horizongtalBarLeftConstrain?.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("end of decelerating")
    }
    
}












