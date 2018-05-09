//
//  CPDetailsVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 9/5/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class CPDetailsVC: UIViewController {
    
    @IBOutlet weak var FullnameLabel: UILabel!
    @IBOutlet weak var ShortnameLabel: UILabel!
    @IBOutlet weak var FavButtonImage: UIBarButtonItem!
    
    var CryptoKey = 0
    var isFav = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("==============<<<<<<<")
        print(CPConstants.Favorite)
        print("==============<<<<<<<")
        checkForFav()

        
        let crypto = CPConstants.CryptoList[CryptoKey] as! NSDictionary
        let name = crypto.object(forKey: "secondary_currency") as! String
        FullnameLabel.text = CPConstants.CryptoFullName[name]
        ShortnameLabel.text = name
        
    }
    
    func checkForFav() {
        if (CPConstants.Favorite.contains(CryptoKey)){
            isFav = true
            FavButtonImage.image = #imageLiteral(resourceName: "HeartsSelected")
        } else {
            isFav = false
            FavButtonImage.image = #imageLiteral(resourceName: "Heart")
        }
    }
    
    @IBAction func FavBtn(_ sender: Any) {
        if isFav {
            //unFev
            CPConstants.Favorite = CPConstants.Favorite.filter { $0 != CryptoKey }
        } else {
            //Fev
            CPConstants.Favorite.append(CryptoKey)
            CPConstants.Favorite.sort()
        }
        checkForFav()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
