//
//  ReviewTableCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-04.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class ReviewTableCell: UITableViewCell {
    
    // MARK: - Cell outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var review:Review?{
        didSet{
            updateViews()
        }
    }
    
    private func updateViews() {
        if let review = review{
            userNameLabel.text = review.userName
            
            ratingControl.starCount = review.rating
            ratingControl.rating = review.rating
            dateLabel.text = review.date
            commentLabel.text = review.comment
            userProfileImageView.loadImageUsingUrlString(urlString: review.userImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
