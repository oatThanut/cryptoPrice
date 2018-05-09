//
//  CPListVC.swift
//  CryptoPrice
//
//  Created by oatThanut on 30/4/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import UIKit

class CPListVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

class ListTableCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ChangeLabel: UILabel!
    @IBOutlet weak var ChangeView: UIView!
    @IBOutlet weak var LogoImage: UIImageView!
    
}
