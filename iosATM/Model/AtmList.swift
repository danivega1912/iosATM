//
//  AtmList.swift
//  iosATM
//
//  Created by Daniel Vega on 5/17/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//
import Foundation
import SwiftyJSON

class ATMlist {
    
    private var atmList:[Atm] = []
    
    init() {
        atmList = []
    }
    
    func getAtmList() -> [Atm] {
        return atmList
    }
    
    func parseAtmJsonList(jsonList:Any) {
        let json = JSON(jsonList)
        
        //iterate over array & fill list
        for item: JSON in json.array! {
            atmList.append(Atm(id: item["id"].intValue,
                               latitude: item["location"]["lat"].doubleValue,
                               longitude: item["location"]["lon"].doubleValue,
                               address: item["address"].stringValue,
                               network: item["network"].stringValue,
                               status: item["status"].stringValue,
                               has_money: item["has_money"].boolValue,
                               accept_deposits: item["accepts_deposits"].boolValue,
                               open_hours: item["open_hours"].stringValue))
        }
    }
}
