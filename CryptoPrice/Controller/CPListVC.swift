//
//  CPListVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 30/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class CPListVC: UITableViewController {
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        self.tableView.reloadData()
    }
    
    func scheduledTimerWithTimeInterval() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        APIClient.instance.retrieveCrypto(success: { (response) in}, error: {})
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CPConstants.CryptoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableCell
        
        let crypto = CPConstants.CryptoList[CPConstants.CryptoKey[indexPath.row]]
        let name: String = (crypto?.object(forKey: "secondary_currency") as? String)!
        cell.LogoImage.image = UIImage(named: "\(name)")!
        cell.NameLabel?.text = name
        
        let change = crypto?.object(forKey: "change") as! Double
        if change >= 0 {
            cell.ChangeView.backgroundColor = UIColor(red: 117/255.0, green: 219/255.0, blue: 25/255.0, alpha: 1)
        }else{
            cell.ChangeView.backgroundColor = UIColor(red: 219/255.0, green: 26/255.0, blue: 26/255.0, alpha: 1)
        }
        cell.ChangeLabel?.text = "\(change)"
        cell.ChangeView.layer.cornerRadius = 3.0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ListSegue", sender: CPConstants.CryptoList[CPConstants.CryptoKey[indexPath.row]]?.object(forKey: "pairing_id"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let instant = segue.destination as! CPDetailsVC
        instant.CryptoKey = sender as! Int
    }

}

class ListTableCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ChangeLabel: UILabel!
    @IBOutlet weak var ChangeView: UIView!
    @IBOutlet weak var LogoImage: UIImageView!
    
}
