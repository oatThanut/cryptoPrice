//
//  FirebaseService.swift
//  CryptoPrice
//
//  Created by oatThanut on 1/5/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Firebase
import FirebaseAuth

class FirebaseService {
    static let instance = FirebaseService()
    var docRef: DocumentReference!
    
    func registerUser(withName name:String, Email email:String, andPassword password:String, userCreationComplete: @escaping (_ status:Bool, _ error:Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard user != nil else {
                userCreationComplete(false, error)
                return
            }
            //set user data
            let userRef = Auth.auth().currentUser?.createProfileChangeRequest()
            userRef?.displayName = name
            userRef?.commitChanges { (editUserError) in
                print("FirebaseAuth edit user profile error: \(String(describing: editUserError?.localizedDescription))")
            }

            self.docRef = Firestore.firestore().document("users/\(user!.uid)")
            let dataToSave: [String: Any] = ["favorite": [1], "pinPrice": ["1": 0]]
            self.docRef.setData(dataToSave) { (setDataError) in
                guard error == nil else {
                    print("Firestore setting data error: \(String(describing: setDataError?.localizedDescription))")
                    return
                }
            }
            
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email:String, andPassword password:String, loginComplete: @escaping(_ status:Bool, _ error:Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard user != nil else {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
