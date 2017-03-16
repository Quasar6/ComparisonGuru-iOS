//
//  ResultListController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-10.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class ResultListController: UITableViewController {
    let cellId = "resultListCell"
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(ResultListCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ResultListCell

        let product = products[indexPath.row]
        cell.productImageView.loadImageUsingUrlString(urlString: product.imageUrl)
        
        cell.productName.text = product.name
        
        var price = products[indexPath.row].price
        if price == 0 {
            price = products[indexPath.row].salePrice
        }
            cell.priceLabel.text = "\(product.currency)  \(price)"
        

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
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
