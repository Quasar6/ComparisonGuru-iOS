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
        sf.returnKeyType = .go
        return sf
    }()
    
    var micButtonTouched: ((Void) -> Void)?
    
    lazy var micButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "ic_mic_black").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Color.searchFieldBorderColor
        button.imageView?.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(voiceIconTouched), for: .touchUpInside)
//        button.isEnabled = false
        return button
    }()
    
    func voiceIconTouched() {
        micButtonTouched?()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        
    }
    
    fileprivate func setupView(){
        
//        searchField.rightView = voiceIconView
        searchField.rightView = micButton
        
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
