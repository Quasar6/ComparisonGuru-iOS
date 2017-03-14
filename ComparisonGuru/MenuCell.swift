//
//  MenuCell.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-13.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let title:UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            title.textColor = isHighlighted ? .black : .gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            title.textColor = isSelected ? .black : .gray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        //x,y,w,h
        title.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        title.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
