//
//  DetailViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var something:Product? {
        didSet{
            print(self.something?.category ?? "")
        }
    }
    
    lazy var subDetailPageView: SubDetailPageViewController = {
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
        subDetailPageView.setViewControllers([subDetailPageView.orderedViewControllers[index]], direction: direction, animated: true) { (ok) in
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
        
        setupMenuBar()
        setupSubviews()
        
        view.backgroundColor = .white
        
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
        subDetailPageView.view.isHidden = false
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
