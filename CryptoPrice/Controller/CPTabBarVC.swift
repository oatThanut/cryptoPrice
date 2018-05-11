//
//  CPHomeVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 29/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class CPTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UITabBar.appearance().barTintColor = UIColor(red:24/255.0,green:151/255.0,blue:254/255.0,alpha:1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
class Tabbar: UITabBarItem {
    override func awakeFromNib() {
        if let image = image {
            self.image = image.withRenderingMode(.alwaysOriginal)
        }
        if let image = selectedImage {
            selectedImage = image.withRenderingMode(.alwaysOriginal)
        }
    }
}
