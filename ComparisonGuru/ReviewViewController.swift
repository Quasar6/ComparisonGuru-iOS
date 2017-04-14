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
import SwiftyJSON

class ReviewViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentPanel: UIView!
    @IBOutlet weak var darkFillView: UIViewX!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var commentPanelBottomConstrain: NSLayoutConstraint!
    
    let countLimit = 140

    let cellId = "reviewCell"
    var product:Product!{
        didSet{
            self.product.reviews?.reverse()
        }
    }
    
    private func updateComments(){
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideCommentPanelElements()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        setupInputAccessoryView()
        addKeyboardObserver()
    }
    
    func addKeyboardObserver(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReviewViewController.updateTextView(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReviewViewController.updateTextView(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func setupInputAccessoryView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        textView.inputAccessoryView = toolBar
    }
    
    func doneButtonClicked(){
        textView.endEditing(true)
    }
    
    @IBAction func submitButtonTouched(_ sender: UIButton) {
        sendComment()
        animateCommentPanel()
        textView.endEditing(true)
    }
    
    func sendComment(){
        
        if let user = FIRAuth.auth()?.currentUser {
            
            let json:JSON = [
                "productId": product.id,
                "comment": textView.text,
                "rating": ratingControl.rating,
                "userName": user.displayName ?? "",
                "userImage": user.photoURL?.absoluteString ?? ""
            ]
            
            Service.sharedInstance.postComment(parameters: json, completion: { (product, error) in
                if let error = error {
                    print(error)
                    return
                }
                self.product = product?.product
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - TableView data
extension ReviewViewController {
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

// MARK: - Animations
extension ReviewViewController {
    @IBAction func toggleButtonTouched(_ sender: UIButton) {
        animateCommentPanel()
    }
    
    fileprivate func animateCommentPanel(){
        if darkFillView.transform == CGAffineTransform.identity {
            UIView.animate(withDuration: 0.2, animations: {
                self.darkFillView.transform = CGAffineTransform(scaleX: 15, y: 15)
                self.commentPanel.transform = CGAffineTransform(translationX: 0, y: -195)
                self.toggleButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            }) { (ok) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.toggleCommentPanelElements()
                })
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.darkFillView.transform = .identity
                self.commentPanel.transform = .identity
                self.toggleButton.transform = .identity
                self.toggleCommentPanelElements()
            })
        }
    }
    
    fileprivate func toggleCommentPanelElements(){
        let alpha = CGFloat(submitButton.alpha == 0 ? 1 : 0)
        ratingControl.alpha = alpha
        textView.alpha = alpha
        submitButton.alpha = alpha
        countLabel.alpha = alpha
    }
    
    fileprivate func hideCommentPanelElements(){
        ratingControl.alpha = 0
        textView.alpha = 0
        submitButton.alpha = 0
        countLabel.alpha = 0
    }
}
extension ReviewViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.textView.resignFirstResponder()
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(countLimit - textView.text.characters.count)"
        
        return textView.text.characters.count + (text.characters.count - range.length) <= countLimit
    }
    
    //manage inset when keyboard show or hide
    func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: self.view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {

            commentPanelBottomConstrain.constant = -195
        } else {
            commentPanelBottomConstrain.constant = keyboardEndFrame.height - 195
        }

    }
    
}












