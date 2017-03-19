//
//  SubDetailPageViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-15.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class SubDetailPageViewController: UIPageViewController {

    var pageSwiped:((_ index:Int) -> Void)?
    
    let myView:OverViewViewController = {
        let view = OverViewViewController()
        return view
    }()
    
    lazy var secondViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    
    lazy var thirdViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .gray
        return vc
    }()
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.myView, self.secondViewController, self.thirdViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        dataSource = self
        delegate = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
}

extension SubDetailPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        guard orderedViewControllers.count > previousIndex else {return nil}
        
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else{return nil}
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {return nil}
        guard orderedViewControllersCount > nextIndex else {return nil}
        
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {


        
        guard let pageContentViewController = pageViewController.viewControllers?[0] else {return}
        guard let currentIndex = orderedViewControllers.index(of: pageContentViewController) else{return}
        
        pageSwiped?(currentIndex)
    }
    
}






