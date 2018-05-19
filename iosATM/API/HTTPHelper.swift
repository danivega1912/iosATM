//
//  HTTPHelper.swift
//  iosATM
//
//  Created by Daniel Vega on 5/17/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//
import Alamofire
import SwiftyJSON

class HTTPHelper {
    //set endpoints
    private let atmStatusEndPoint = "http://ucu-atm.herokuapp.com/api/atm"
    
    func getAtmList(completion: @escaping (ATMlist, Bool) -> ()) {
        let atmList:ATMlist = ATMlist()
        
        Alamofire.request(atmStatusEndPoint).responseJSON { response in
            if let json = response.result.value {
                atmList.parseAtmJsonList(jsonList: json)
                completion(atmList, false)
            } else {
                completion(atmList, true)
            }
        }
    }
    
}
