//
//  CPLoginVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 29/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit
import FirebaseAuth

class CPLoginVC: UIViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        let email: String = EmailTextField.text!
        let password: String = PasswordTextField.text!
        
        if(email != "" && password != "" ){
            FirebaseService.instance.loginUser(withEmail: email, andPassword: password,
            loginComplete: { (success, loginError) in
                if success {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let HomeVC = storyBoard.instantiateViewController(withIdentifier: "Home") as! CPTabBarVC
                    self.navigationController?.pushViewController(HomeVC, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: loginError?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please enter email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
