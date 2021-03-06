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

//import AVFoundation

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
        sf.translatesAutoresizingMaskIntoConstraints = false
        sf.searchField.delegate = self
        sf.micButtonTouched = {[weak self] in
//            self?.askSpeechPermission()
            self?.goToSpeechRecognitionViewController()
        }
        return sf
    }()
    
    func goToSpeechRecognitionViewController() {
        
//        let speechVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpeechRecognitionViewController")
        guard let speechVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {return}
        
        navigationController?.present(speechVC, animated: true, completion: nil)
    }
    
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
    
    var trendingProducts = [Product]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTrendingProducts()
        
        view.backgroundColor = .white
        collectionView.layer.masksToBounds = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = navBarView
        setupViews()
        collectionView.register(FrequentSearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    func loadTrendingProducts(){
        Service.sharedInstance.fetchFrequentSearchedProduct { (trendDatasource, err) in
            if let _ = err {
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print(apiError.response?.statusCode ?? "not found status code")
                    }
                }
                return
            }
            
            if let trendingProducts = trendDatasource?.products {
                self.trendingProducts = trendingProducts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
// MARK: collection view cell section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FrequentSearchCell
        
        if !trendingProducts.isEmpty {
            cell.trendingProduct = trendingProducts[indexPath.item]
        }
        
        
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
        let detailViewController = DetailViewController()
        detailViewController.product = trendingProducts[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
        
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


















