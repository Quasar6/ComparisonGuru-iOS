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
            
            dateLabel.text = convertDateToTimeAgo(to:review.date)
            commentLabel.text = review.comment
            userProfileImageView.loadImageUsingUrlString(urlString: review.userImage)
        }
    }
    
    func convertDateToTimeAgo(to date: String) -> String {
        let myCurrentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" //"2017-04-10T00:31:44-04:00"
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.maximumUnitCount = 1
        //For example, if minutes aren't allowed, then "1h 30m" could be formatted as "1.5h". Default is NO
        formatter.allowsFractionalUnits = false
        if let timeStamp = formatter.string(from: date, to: myCurrentDate){
            return "\(timeStamp) ago"
        } else {
            return ""
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
