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
    
    func retrieveCrypto(success: @escaping (Dictionary<String, Any>) -> (), error: @escaping() -> ()) {
        Alamofire.request("\(CPConstants.BASE_URL)").responseJSON { response in
            print(response.result.value)
        }
    }
}
