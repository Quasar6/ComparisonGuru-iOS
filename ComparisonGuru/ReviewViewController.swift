//
//  ReviewViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-03.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ReviewViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    let cellId = "reviewCell"
    var product:Product?
    
    @IBAction func signIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    private func updateComments(){
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReviewTableCell
        
        if let review = product?.reviews?[indexPath.row]{
            cell.review = review
        }
        
        
        return cell
    }
    

}
