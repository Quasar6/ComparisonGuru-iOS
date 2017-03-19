//
//  LoadingView.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-17.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        indicator.color = .lightGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading......"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    private func setupViews() {
        addSubview(indicator)
        indicator.anchorCenterSuperview()
        
        addSubview(loadingLabel)
        loadingLabel.anchor(indicator.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
    
    override var isHidden: Bool {
        didSet{
            if !self.isHidden {
                self.indicator.startAnimating()
            } else {
                self.indicator.stopAnimating()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
