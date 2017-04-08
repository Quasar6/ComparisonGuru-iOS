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
    
    var product:Product?{
        didSet{
            passProduct()
        }
    }
    
    private func passProduct(){
        myView.product = self.product
        reviewViewController.product = self.product
    }
    
    let myView:OverViewViewController = {
        let view = OverViewViewController()
        return view
    }()
    
    lazy var secondViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: vc.view.frame.midX, y: vc.view.frame.midY, width: 100, height: 30))
            label.text = "Page 2"
        vc.view.addSubview(label)
        return vc
    }()
    
    lazy var reviewViewController: ReviewViewController = {
        let vc = UIStoryboard(name: "DetailPage", bundle: nil).instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        
        return vc
    }()
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.myView, self.secondViewController, self.reviewViewController]
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






