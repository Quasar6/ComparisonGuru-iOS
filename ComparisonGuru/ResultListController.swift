//
//  ResultListController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-10.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResultListController: UITableViewController {
    let cellId = "resultListCell"
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationController?.hidesBarsOnSwipe = true
        
        setupNavItems()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(ResultListCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
    }

    private func setupNavItems(){
        let leftButton = UIBarButtonItem(title: " Home", style: .plain, target: self, action: #selector(handleLeftNavButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func handleLeftNavButtonClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    func whiteStatusBarBackground(){
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        whiteView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden ?? false
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ResultListCell
        cell.product = products[indexPath.row]
        
        return cell
    }
    
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 150, height: 30))
        label.text = "Results: "
        label.textColor = .gray
        view.addSubview(label)
        return view
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        
            var product = products[indexPath.row]
            detailViewController.product = product
        
        //prevent constantly update one product by multiple clicks
        if !product.triggeredHit {
            Service.sharedInstance.updateTrendingProduct(parameters: product.toJSON()) { (error) in
                if let error = error {
                    print(error)
                }
                product.triggeredHit = true
            }
        }

        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}
