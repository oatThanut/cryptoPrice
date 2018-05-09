//
//  CPConstants.swift
//  CryptoPrice
//
//  Created by oatThanut on 6/5/2561 BE.
//  Copyright © 2561 oatThanut. All rights reserved.
//

import Foundation

class CPConstants {
    static let BASE_URL = "https://bx.in.th/api/"
    static let CryptoFullName = ["BTC":"Bitcoin", "BCH":"BitcoinCash", "DAS":"Dash",
                                 "DOG":"Dogecoin", "ETH":"Ethereum", "EVX":"Everex Token",
                                 "FTC":"Feathercoin", "GNO":"Gnosis", "HYP":"HyperStake",
                                 "LTC":"Litecoin", "NMC":"Namecoin", "OMG":"Omise Go",
                                 "PND":"Pandacoin", "POW":"Power Ledger", "PPC":"Peercoin",
                                 "QRK":"Quark", "REP":"Augur", "XCN":"Cryptonite",
                                 "XPM":"Primecoin", "XPY":"Paycoin", "XRP":"Ripple",
                                 "XZC":"Zcoin", "ZEC":"Zcash"]
    
    static var CryptoList: [Int: NSDictionary] = [:]
    static var CryptoKey: [Int] = []
    static var Favorite: [Int] = []
}
