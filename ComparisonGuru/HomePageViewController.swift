//
//  HomePageViewController.swift
//  ComparisonGuru
//
//  Created by Wenzhong Zheng on 2017-04-06.
//  Copyright © 2017 Wenzhong. All rights reserved.
//

import UIKit
import TRON
import Firebase
import GoogleSignIn

class HomePageViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var topUserInfoView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Login Outlets
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // MARK: - Variables or Constants
    fileprivate var trendingProducts = [Product]()
    fileprivate let cellId = "homePageCell"
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.backgroundColor = .lightGray
        view.isHidden = true
        return view
    }()
    
    lazy var micButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "ic_mic_black").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Color.searchFieldBorderColor
        button.imageView?.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(goToSpeechRecognitionViewController), for: .touchUpInside)
        return button
    }()
    
    func goToSpeechRecognitionViewController() {
        let speechVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpeechRecognitionViewController")
        present(speechVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrendingProducts()
        collectionView.layer.masksToBounds = false
        setupSearchField()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        observeUserState()
        
    }
    
    var userStateHandler:FIRAuthStateDidChangeListenerHandle!
    
    @IBOutlet weak var topUserSignInButtonLeftConstrain: NSLayoutConstraint!
    @IBOutlet weak var topUserInfoViewLeftConstrain: NSLayoutConstraint!
    @IBOutlet weak var signOutButtonTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet var signOutBackgroundView: UIView!
    
    private func showSignOutBackgroundView(){
        view.insertSubview(signOutBackgroundView, belowSubview: signOutButton)
        
        signOutBackgroundView.fillSuperview()
        signOutBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSignOutBackgroundViewTouched)))
        view.layer.layoutIfNeeded()
    }
    
    @objc private func handleSignOutBackgroundViewTouched(){
        hideSignOutButton()
        signOutBackgroundView.removeFromSuperview()
    }
    
    //show a sign out button
    @IBAction func topUserInfoViewTouched(_ sender: UITapGestureRecognizer) {
        showSignOutBackgroundView()
        signOutButtonTopConstrain.constant = 40
        signOutButton.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
        }, completion: nil)
    }
    //hide sign out button
    private func hideSignOutButton(){
        signOutButtonTopConstrain.constant = 0
        signOutButton.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func signOutButtonClicked(_ sender: UIButton) {
        signOutUser()
        hideSignOutButton()
    }
    
    
    //listening auth state change
    private func observeUserState(){
        userStateHandler = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.dismissLoginView()
                self.showUserInfoView(loginUser: user)
            } else {
                self.hideUserInfoView()
            }
        })
    }
    
    private func showUserInfoView(loginUser:FIRUser){
        topUserInfoViewLeftConstrain.constant = 0
        topUserSignInButtonLeftConstrain.constant = -150
        if let url = loginUser.photoURL {
            userImage.loadImageUsingUrlString(urlString: "\(url)")
        }
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
        }, completion: nil)
        userName.text = loginUser.displayName
    }
    
    private func hideUserInfoView(){
        topUserSignInButtonLeftConstrain.constant = -16
        topUserInfoViewLeftConstrain.constant = -255
        signOutButtonTopConstrain.constant = 0
        signOutButton.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeUserStateObserver()
    }
    
    private func removeUserStateObserver(){
        FIRAuth.auth()?.removeStateDidChangeListener(userStateHandler)
    }
    
    // MARK: - handle login view
    @IBAction func signInButtonTouched(_ sender: UIButton) {
        
        view.addSubview(loginView)
        loginView.fillSuperview()
        loginView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            self.loginView.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func loginViewDismissButtonTouched(_ sender: UIButton) {
        signOutUser()
        if loginView.superview != nil {
            dismissLoginView()
        }
    }
    
    private func signOutUser(){
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private func dismissLoginView(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.loginView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { (success) in
            self.loginView.removeFromSuperview()
        })
    }
    
    private func setupSearchField(){
        searchField.rightView = micButton
        searchField.rightViewMode = .always
        searchField.layer.borderWidth = 1.0
        searchField.layer.borderColor = UIColor.lightGray.cgColor//Color.searchFieldBorderColor.cgColor
        searchField.layer.cornerRadius = 10
        searchField.layer.masksToBounds = false
        
        searchField.layer.shadowOpacity = 0.3
        searchField.layer.shadowRadius = 2
        searchField.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    let loadingBackgroundView = UIView()
    fileprivate func showLoadingView(){
        
        view.addSubview(loadingBackgroundView)
        loadingBackgroundView.fillSuperview()
        loadingBackgroundView.alpha = 0.7
        loadingBackgroundView.backgroundColor = .black
        
        
        view.addSubview(loadingView)
        loadingView.isHidden = false
        loadingView.anchorCenterSuperview()
        loadingView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        loadingView.loadingLabel.text = "Loading..."
        loadingView.cancelButton.addTarget(self, action: #selector(hideLoadingView), for: .touchUpInside)
    }
    @objc fileprivate func hideLoadingView(){
        loadingBackgroundView.removeFromSuperview()
        loadingView.removeFromSuperview()
    }
    
    
    func handleSearched(text: String) {
        Service.sharedInstance.fetchHomeFeed(productName: text) { (homeDatasource, err) in
            if let _ = err {
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print(apiError.response?.statusCode ?? "not found status code")
                        self.loadingView.indicator.stopAnimating()
                        self.loadingView.loadingLabel.text = "Error Code: \(apiError.response?.statusCode)"
                        
                    }
                }
                return
            }
            self.hideLoadingView()
            let resultController = ResultListController()
            guard let products = homeDatasource?.products else {return}
            resultController.products = products
            let navController = UINavigationController(rootViewController: resultController)
            navController.navigationBar.isTranslucent = false
            self.present(navController, animated: true)
        }
    }
    
    func loadTrendingProducts(){
        Service.sharedInstance.fetchFrequentSearchedProduct { (trendDatasource, err) in
            if let _ = err {
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print(apiError.response?.statusCode ?? "not found status code")
                    }
                }
                return
            }
            if let trendingProducts = trendDatasource?.products {
                self.trendingProducts = trendingProducts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: collection view cell section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePageViewCell
        
        if !trendingProducts.isEmpty {
            cell.trendingProduct = trendingProducts[indexPath.item]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: collectionView.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you did selected \(indexPath.item) item")
        let detailViewController = DetailViewController()
        detailViewController.product = trendingProducts[indexPath.item]
        
        let navController = UINavigationController(rootViewController: detailViewController)
        
        
        present(navController, animated: true){
            navController.navigationBar.isTranslucent = false
            let leftButton = UIBarButtonItem(title: " Home", style: .plain, target: detailViewController, action: #selector(detailViewController.handleDismiss))
            detailViewController.navigationItem.leftBarButtonItem = leftButton
        }
        
    }
}

extension HomePageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if text != "" {
            showLoadingView()
            handleSearched(text: text)
            print(text)
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchField.endEditing(true)
    }
}
