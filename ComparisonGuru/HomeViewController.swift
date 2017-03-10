//
//  ViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let cellId = "cellId"
    let frequentHeaderId = "frequentHeaderId"
    
    let navBarView: NavBarView = {
        let navBar = NavBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    let searchField: SearchFieldView = {
        let sf = SearchFieldView()
        sf.translatesAutoresizingMaskIntoConstraints = false
        return sf
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frequently Browsed"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
//        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.layer.masksToBounds = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = navBarView
        setupViews()

        collectionView.register(FrequentSearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupViews() {
        view.addSubview(searchField)
        searchField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(headerLabel)
        //x,y,w,h
        headerLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }


}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
// MARK: collection view cell section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FrequentSearchCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: collectionView.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

