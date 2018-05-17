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
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = . reloadIgnoringLocalAndRemoteCacheData
        
        var req = URLRequest(url: URL(string: "\(CPConstants.BASE_URL)")!)
        req.httpMethod = "GET"
        req.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        Alamofire.request(req).validate().responseJSON { response in
            if response.result.isSuccess {
                let dict = response.result.value as! NSDictionary
                CPConstants.CryptoList.removeAll()
                CPConstants.CryptoKey.removeAll()
                for index in dict {
                    let key:Int = (index.key as AnyObject).intValue
                    CPConstants.CryptoKey.append(key)
                    CPConstants.CryptoList[key] = (dict.object(forKey: key.description) as! NSDictionary)
                }
                CPConstants.CryptoKey.sort()
                success(response.result.value as! NSDictionary)
            } else {
                
            }
        }
    }
    
    
    
    func retrieveResentTrade(Coin: String,success: @escaping () -> (), error: @escaping() -> ()) {
        var req = URLRequest(url: URL(string: "\(CPConstants.RESENT_URL)\(Coin)")!)
        req.httpMethod = "GET"
        req.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        Alamofire.request(req).validate().responseJSON { response in
            if response.result.isSuccess {
                let dict = response.result.value as! NSDictionary
                let trade = dict.object(forKey: "trades") as! NSArray
                
                for x in trade {
                    print()
                    let order = x as! NSDictionary
                    order.object(forKey: "trade_id")
                    
                    let key:Int = Int((order.object(forKey: "trade_id") as! NSString).intValue)
                    CPConstants.TradeKey.append(key)
                    CPConstants.TradeKey.sort(by: >)
                    CPConstants.TradeSet[Int((order.object(forKey: "trade_id") as! NSString).intValue)] = order
                }
            }
        }
    }
    
}
