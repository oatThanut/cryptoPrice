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
        UITabBar.appearance().barTintColor = UIColor(red:24/255.0,green:151/255.0,blue:254/255.0,alpha:1)
    }

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
