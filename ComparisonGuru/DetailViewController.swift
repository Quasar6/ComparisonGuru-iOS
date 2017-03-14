//
//  DetailViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let menuBarView: MenuBarView = {
        let menuBar = MenuBarView()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        setupScrollView()
        setupMenuBar()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.frame)
        scrollView.backgroundColor = .orange
        scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: view.bounds.height)
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view1.backgroundColor = .red
        
        let view2 = UIView(frame: CGRect(x: scrollView.frame.width, y: 0, width: view.frame.width, height: view.frame.height))
        view1.backgroundColor = .blue
        
//        let view3 = UIView(frame: CGRect(x: scrollView.frame.width * 2, y: 0, width: view.frame.width, height: view.frame.height))
//        view1.backgroundColor = .green
        
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
//        scrollView.addSubview(view3)
    }
    
    func setupMenuBar(){
        view.addSubview(menuBarView)
        menuBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
    
}
