//
//  CPHomeVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 30/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit
import FirebaseAuth

class CPHomeVC: UITableViewController {
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseService.instance.retrieveFavorite()
        scheduledTimerWithTimeInterval()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func scheduledTimerWithTimeInterval() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        print("=============Updated")
        APIClient.instance.retrieveCrypto(success: { (response) in}, error: {})
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CPConstants.Favorite.count
    }
    
    @IBAction func LogoutBtn(_ sender: Any) {
        CPConstants.LogKeeper.removeAll()
        DataKeeeper()
        FirebaseService.instance.updateFavorite()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        try! Auth.auth().signOut()
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "Login") as! CPLoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func DataKeeeper() {
        for index in CPConstants.Favorite {
            CPConstants.LogKeeper["\(index)"] = CPConstants.CryptoList[index]?.object(forKey: "last_price") as! Double
            
            print(CPConstants.LogKeeper)
        }
        
    }

    let a = ["asd", "awer", "etre"]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        let crypto = CPConstants.CryptoList[CPConstants.Favorite[indexPath.row]] as! NSDictionary
        let name: String = (crypto.object(forKey: "secondary_currency") as? String)!
        
        cell.LogoImage.image = UIImage(named: "\(name)")!
        cell.FullnameLabel.text = CPConstants.CryptoFullName[name]
        cell.ShortNameLabel.text = name
        let change = crypto.object(forKey: "change") as! Double
        if change >= 0 {
            cell.ChangeImage.backgroundColor = UIColor(red: 117/255.0, green: 219/255.0, blue: 25/255.0, alpha: 1)
        }else{
            cell.ChangeImage.backgroundColor = UIColor(red: 219/255.0, green: 26/255.0, blue: 26/255.0, alpha: 1)
        }
        cell.ChangeLabel?.text = "\(change)"
        cell.ChangeImage.layer.cornerRadius = 3.0
        let lastPrice: Double = crypto.object(forKey: "last_price") as! Double
        let unit: String = crypto.object(forKey: "primary_currency") as! String
        if lastPrice < 20.0 {
            cell.lastPrice.text = NSString(format: "%9f %@", lastPrice, unit) as String
        } else {
            cell.lastPrice.text = "\(lastPrice) \(unit)"
        }
        
        cell.Volume.text = "\(crypto.object(forKey: "volume_24hours") as! Double)"
        
        cell.bg.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        cell.bg.layer.cornerRadius = 3.0
        cell.bg.layer.masksToBounds = false
        cell.bg.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        cell.bg.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.bg.layer.shadowOpacity = 0.8

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeSegue", sender: CPConstants.CryptoList[CPConstants.Favorite[indexPath.row]]?.object(forKey: "pairing_id"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let instant = segue.destination as! CPDetailsVC
        instant.CryptoKey = sender as! Int
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var FullnameLabel: UILabel!
    @IBOutlet weak var ShortNameLabel: UILabel!
    @IBOutlet weak var lastPrice: UILabel!
    @IBOutlet weak var Volume: UILabel!
    @IBOutlet weak var ChangeImage: UIView!
    @IBOutlet weak var ChangeLabel: UILabel!
    
}
