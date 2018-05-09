//
//  AlamofireService.swift
//  CryptoPrice
//
//  Created by oatThanut on 6/5/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static let instance = APIClient()
    
    func retrieveCrypto(success: @escaping (NSDictionary) -> (), error: @escaping() -> ()) {
        Alamofire.request("\(CPConstants.BASE_URL)").responseJSON { response in
            if response.result.isSuccess {
                let dict = response.result.value as! NSDictionary
                
                for index in dict {
                    let key:Int = (index.key as AnyObject).intValue
                    CPConstants.CryptoKey.append(key)
                    CPConstants.CryptoList[key] = (dict.object(forKey: key.description) as! NSDictionary)
                }
                CPConstants.CryptoKey.sort()
                print(CPConstants.CryptoList[1])
                success(response.result.value as! NSDictionary)
            } else {
                
            }
        }
    }
    
    func retrieveResentTrade(Coin: String,success: @escaping () -> (), error: @escaping() -> ()) {
        Alamofire.request("\(CPConstants.RESENT_URL)\(Coin)").responseJSON { response in
            if response.result.isSuccess {
                let dict = response.result.value as! NSDictionary
                let trade = dict.object(forKey: "trades") as! NSArray
                
                for x in trade {
                    print()
                    let order = x as! NSDictionary
                    order.object(forKey: "trade_id")
                    
                    let key:Int = Int((order.object(forKey: "trade_id") as! NSString).intValue)
                    CPConstants.TradeKey.append(key)
                    CPConstants.TradeKey.sort(by: <)
                    CPConstants.TradeSet[Int((order.object(forKey: "trade_id") as! NSString).intValue)] = order
                    
                }
//                print(CPConstants.TradeSet)
            }
        }
    }
    
}
