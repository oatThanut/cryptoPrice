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
                    CPConstants.CryptoList[key] = (dict.object(forKey: key.description) as! NSDictionary)
                }
                
                success(response.result.value as! NSDictionary)
            } else {
                
            }
        }
    }
    
    
}
