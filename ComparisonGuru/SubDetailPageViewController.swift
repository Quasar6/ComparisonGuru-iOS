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
    
    lazy var firstViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        button.setTitle("Click me", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        vc.view.addSubview(button)
        
        return vc
    }()
    
    func buttonClicked(){
        print("I'm Clicked")
        setViewControllers([secondViewController], direction: .forward, animated: true, completion: nil)
    }
    
    
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
        return [self.firstViewController, self.secondViewController, self.thirdViewController]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = nil
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
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
}






