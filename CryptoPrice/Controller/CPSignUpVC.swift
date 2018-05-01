//
//  CPSignUpVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 29/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit
import FirebaseAuth

class CPSignUpVC: UIViewController {

    @IBOutlet weak var FirstnameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        let name = FirstnameTextField.text!
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        let confirmPassword = ConfirmPasswordTextField.text!
        
        if(name != "" && email != "" && password != "" && confirmPassword != "") {
            if(password == confirmPassword) {
                FirebaseService.instance.registerUser(withName: name, Email: email, andPassword: password,
                    userCreationComplete: { (success, registerError) in
                        if success {
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let HomeVC = storyBoard.instantiateViewController(withIdentifier: "Home") as! CPTabBarVC
                            self.navigationController?.pushViewController(HomeVC, animated: true)
                        } else {
                            let alertController = UIAlertController(title: "Error", message: registerError?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                })
       
            } else {
                let alertController = UIAlertController(title: "Password doesn't match", message: "Please enter the password again!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please fill all information", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
