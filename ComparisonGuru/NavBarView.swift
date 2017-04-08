//
//  NavBarView.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class NavBarView: UIView {

    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "logolow")
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lbl.textColor = .white
        lbl.text = "ComparisonGuru"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        containerView.addSubview(iconImageView)
        //x,y,w,h
        iconImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(nameLabel)
        //x,y,w,h
        nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
