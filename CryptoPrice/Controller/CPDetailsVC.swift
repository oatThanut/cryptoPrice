//
//  CPDetailsVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 9/5/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class CPDetailsVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var FullnameLabel: UILabel!
    @IBOutlet weak var ShortnameLabel: UILabel!
    @IBOutlet weak var FavButtonImage: UIBarButtonItem!
    @IBOutlet weak var LastestPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var CryptoKey = 0
    var isFav = false

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFav()
        updateData()
        checkTrade()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func updateData() {
        let crypto = CPConstants.CryptoList[CryptoKey] as! NSDictionary
        let name = crypto.object(forKey: "secondary_currency") as! String
        let lastPrice: Double = crypto.object(forKey: "last_price") as! Double
        let unit: String = crypto.object(forKey: "primary_currency") as! String
        LogoImage.image = UIImage(named: name)
        FullnameLabel.text = CPConstants.CryptoFullName[name]
        ShortnameLabel.text = name
        
        if lastPrice > 20.0 {
            LastestPriceLabel.text = "Lastest price:      \(lastPrice) \(unit)"
        } else {
            LastestPriceLabel.text = NSString(format: "Lastest price:      %9f %@", lastPrice, unit) as String
        }
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
    
    func checkTrade() {
        CPConstants.TradeKey.removeAll()
        CPConstants.TradeSet.removeAll()
        APIClient.instance.retrieveResentTrade(Coin: "\(CryptoKey)", success: {}) {}
    }
    
    @IBAction func FavBtn(_ sender: Any) {
        if isFav {
            CPConstants.Favorite = CPConstants.Favorite.filter { $0 != CryptoKey }
        } else {
            CPConstants.Favorite.append(CryptoKey)
            CPConstants.Favorite.sort()
        }
        checkForFav()
        FirebaseService.instance.updateFavorite()
    }
    
    @IBAction func RefreshBtn(_ sender: Any) {
        checkTrade()
        APIClient.instance.retrieveCrypto(success: { (response) in }) {}
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CPConstants.TradeKey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TradeCell", for: indexPath) as! TradeCell
        
        let trade = CPConstants.TradeSet[CPConstants.TradeKey[indexPath.row]] as! NSDictionary
        
        let second = trade.object(forKey: "seconds") as! Double
        if second/60.0 < 1.0 {
            cell.TimeLabel.text = NSString(format: "%.1f sec.", second) as String
        } else {
            cell.TimeLabel.text = NSString(format: "%.2f min.", second/60.0) as String
        }
        
        let rate = (trade.object(forKey: "rate") as! NSString).doubleValue
        if rate > 20.0 {
            cell.ReRateLabel.text = "\(rate)"
        } else {
            cell.ReRateLabel.text = NSString(format: "%9f", rate) as String
        }
        
        cell.VolumeLabel.text = trade.object(forKey: "amount") as? String
        let type = trade.object(forKey: "trade_type") as! String
        if type == "buy" {
            cell.TradeImage.image = UIImage(named: "Buy")
        } else {
            cell.TradeImage.image = UIImage(named: "Sell")
        }

        return cell
    }

}

class TradeCell: UITableViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ReRateLabel: UILabel!
    @IBOutlet weak var VolumeLabel: UILabel!
    @IBOutlet weak var TradeImage: UIImageView!
}
