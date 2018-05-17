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
    let userUid = Auth.auth().currentUser?.uid
    
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
            let dataToSave: [String: Any] = ["favorite": [1], "Keeper": ["1": 0.0] ]
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
                if self.userUid != Auth.auth().currentUser!.uid {
                    CPConstants.Favorite.removeAll()
                }
                return
            }
            loginComplete(true, nil)
        }
    }
    
    func retrieveFavorite(){
        let favRef = Firestore.firestore().document("users/\(Auth.auth().currentUser!.uid)")
        favRef.getDocument { (document, error) in
            let favData = document?.data() as! NSDictionary
            let fav = favData.object(forKey: "favorite") as! Array<Int>
            let kee = favData.object(forKey: "Keeper") as! [String : Double]
            CPConstants.Favorite = fav
            CPConstants.LogKeeper = kee
        }
    }
    
    func updateFavorite() {
        let favRef = Firestore.firestore().document("users/\(Auth.auth().currentUser!.uid)")
        favRef.setData(["favorite": CPConstants.Favorite, "Keeper": CPConstants.LogKeeper])
    }
}
