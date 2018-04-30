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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        let name = FirstnameTextField.text!
        let email = EmailTextField.text!
        let password = PasswordTextField.text!
        let confirmPassword = ConfirmPasswordTextField.text!
        
        if(name != "" || email != "" || password != "" || confirmPassword != "") {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                guard let user = user else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                Auth.auth().currentUser?.createProfileChangeRequest().displayName = name
                print(">>> success")
                self.navigateToHome()
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please fill all information", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func navigateToHome() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyBoard.instantiateViewController(withIdentifier: "Home") as! CPHomeVC
        self.navigationController?.pushViewController(HomeVC, animated: true)
    }

}
