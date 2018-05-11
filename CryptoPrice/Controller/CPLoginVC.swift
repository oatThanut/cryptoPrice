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
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
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
                    APIClient.instance.retrieveCrypto(success: { (response) in
                        var messageAlert = ""
                        print("================================")
                        for index in CPConstants.Favorite {
                            let crypto = CPConstants.CryptoList[index] as! NSDictionary
                            let name = crypto.object(forKey:"secondary_currency") as! String
                            let pass = CPConstants.LogKeeper["\(index)"] as! Double
                            print("\(pass) - \(crypto.object(forKey: "last_price"))")
                            let change = pass - (crypto.object(forKey: "last_price") as! Double )
                            print("+++___+++\(change)")
                            if change != 0 {
                                messageAlert += "\(name)'s value change for \(change)\n"
                            }
                        }
                        if messageAlert != "" {
                            let alertController = UIAlertController(title: "Something was change!!", message: messageAlert, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                            print(">>>> \(CPConstants.LogKeeper)")
                        }
                        CPConstants.LogKeeper.removeAll()
                    }, error: {})
                    
                    
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
