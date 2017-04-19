//
//  DetailViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var product:Product? {
        didSet{
            print(self.product?.category ?? "no product received")
            subDetailPageViewController.product = product
        }
    }
    var trendingProducts:[Product]?{
        didSet{
            subDetailPageViewController.trendingProducts = trendingProducts
        }
    }
    
    lazy var subDetailPageViewController: SubDetailPageViewController = {
        let vc = SubDetailPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.addViewControllerAsChildViewController(childViewController:vc)
        vc.pageSwiped = {[weak self](index) in
            self?.changeTopMenuBarPosition(index:index)
        }
        return vc
    }()
    
    func changeTopMenuBarPosition(index:Int) {
        menuBarView.scrollToMenuIndex(menuIndex: index)
    }
    
    lazy var menuBarView: MenuBarView = {
        let menuBar = MenuBarView()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.tappedAction = {[weak self](index) in
            self?.changeCurrentPageView(index:index)
        }
        return menuBar
    }()
    
    var preIndex:Int = 0
    func changeCurrentPageView(index:Int) {
        let direction = index > preIndex ? UIPageViewControllerNavigationDirection.forward : UIPageViewControllerNavigationDirection.reverse
        subDetailPageViewController.setViewControllers([subDetailPageViewController.orderedViewControllers[index]], direction: direction, animated: true) { (ok) in
            if ok {
                self.preIndex = index
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isNavigationBarHidden = false

        navigationController?.hidesBarsOnSwipe = false
//        setupNavigation()
        
        setupMenuBar()
        setupSubviews()
        
        view.backgroundColor = .white
        
        
    }
    
    func setupNavigation() {
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleDismiss))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftButton
//        navigationController?.navigationItem.leftBarButtonItem =
        navigationController?.navigationBar.barTintColor = Color.menuBarTintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }

    func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    func setupMenuBar(){
        view.addSubview(menuBarView)
        menuBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}
    // MARK: - deal with subview controllers
extension DetailViewController {
    
    fileprivate func setupSubviews() {
        subDetailPageViewController.view.isHidden = false
    }
    
    
    fileprivate func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        view.addSubview(childViewController.view)
        
        childViewController.view.anchor(menuBarView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        childViewController.didMove(toParentViewController: self)
    }
    
    // MARK: - remove childviewController
    fileprivate func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
    

}
