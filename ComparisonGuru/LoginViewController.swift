//
//  LoginViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-14.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    var userStateHandler:FIRAuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        googleSignInButton.style = .wide
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeUserState()
    }

    private func observeUserState(){
        userStateHandler = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                self.dismissDidTap()
            }
        })
    }
    
    deinit {
        FIRAuth.auth()?.removeStateDidChangeListener(userStateHandler)
    }
    @IBAction func dismissDidTap() {
        dismiss(animated: true, completion: nil)
    }

}
