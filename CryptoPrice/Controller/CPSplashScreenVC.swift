//
//  ViewController.swift
//  CryptoPrice
//
//  Created by oatThanut on 17/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit
import FirebaseAuth

class CPSplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        APIClient.instance.retrieveCrypto(success: { (response) in}, error: {})
        if Auth.auth().currentUser != nil {
            // User is signed in.
            FirebaseService.instance.retrieveFavorite()
            self.navigateToHome()
        } else {
            // No user is signed in.
            self.navigateToLogin()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigateToLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "Login") as! CPLoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func navigateToHome() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyBoard.instantiateViewController(withIdentifier: "Home") as! CPTabBarVC
        self.navigationController?.pushViewController(HomeVC, animated: true)
    }

}

