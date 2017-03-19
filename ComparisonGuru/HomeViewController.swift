//
//  ViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

class HomeViewController: UIViewController {

    let cellId = "cellId"
    let frequentHeaderId = "frequentHeaderId"
    
    let navBarView: NavBarView = {
        let navBar = NavBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    lazy var searchField: SearchFieldView = {
        let sf = SearchFieldView()
        sf.searchField.delegate = self
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
        cv.showsHorizontalScrollIndicator = false
//        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.backgroundColor = .lightGray
        view.isHidden = true
        return view
    }()
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNeedsStatusBarAppearanceUpdate()
//        self.modalPresentationCapturesStatusBarAppearance = true
//        self.navigationController?.navigationBar.barStyle = .black
        
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
        headerLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 40).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(loadingView)
        loadingView.anchorCenterSuperview()
        loadingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    func handleSearched(text: String) {
        
        Service.sharedInstance.fetchHomeFeed(productName: text) { (homeDatasource, err) in
            if let _ = err {
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print(apiError.response?.statusCode ?? "not found status code")
                    }
                }
                return
            }
            self.loadingView.isHidden = true
            let resultController = ResultListController()
            guard let products = homeDatasource?.products else {return}
            resultController.products = products
            self.navigationController?.pushViewController(resultController, animated: true)
            
        }
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you did selected \(indexPath.item) item")
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if text != "" {
            loadingView.isHidden = false
            handleSearched(text: text)
            print(text)
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchField.endEditing(true)
    }
}
