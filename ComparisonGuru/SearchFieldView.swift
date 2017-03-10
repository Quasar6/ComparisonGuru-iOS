//
//  SearchFieldView.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-03-09.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit

class SearchFieldView: UIView {

    let searchField: UITextField = {
        let sf = UITextField()
        sf.translatesAutoresizingMaskIntoConstraints = false
        sf.placeholder = "Search here"
        sf.textAlignment = .center
        sf.layer.borderWidth = 2.0
        sf.layer.borderColor = Color.searchFieldBorderColor.cgColor
        sf.layer.cornerRadius = 10
        sf.layer.masksToBounds = true
        sf.rightViewMode = .always
        return sf
    }()
    
    lazy var voiceIconView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iv.image = #imageLiteral(resourceName: "ic_mic_black").withRenderingMode(.alwaysTemplate)
        iv.tintColor = Color.searchFieldBorderColor
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(voiceIconTouched)))
        return iv
    }()
    
    func voiceIconTouched() {
        print("Voice Voice")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        
    }
    
    fileprivate func setupView(){
        
        searchField.rightView = voiceIconView
        addSubview(searchField)
        searchField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        searchField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        searchField.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
