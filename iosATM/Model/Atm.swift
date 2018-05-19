//
//  Atm.swift
//  iosATM
//
//  Created by Daniel Vega on 5/17/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//

import Foundation
import MapKit


class Atm {
    
    private var id:Int
    private var latitude:Double
    private var longitude:Double
    private var address:String
    private var network:String
    private var status:String
    private var has_money:Bool
    private var accepts_deposits:Bool
    private var open_hours:String
    
    
    
    init(id:Int, latitude:Double, longitude:Double, address:String, network:String, status:String, has_money:Bool, accept_deposits:Bool, open_hours: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.network = network
        self.status = status
        self.has_money = has_money
        self.accepts_deposits = accept_deposits
        self.open_hours = open_hours
        
    }
    
    func getId() -> Int {
        return id
    }
    
    func getLatitude() -> Double {
        return latitude
    }
    
    func getLongitude() -> Double {
        return longitude
    }
    
    func getAddress() -> String {
        return address
    }
    
    func getNetwork() -> String {
        return network
    }
    
    func getStatus() -> String {
        return status
    }
    
    func getHasMoney() -> Bool {
        return has_money
    }
    
    func getAcceptDeposits() -> Bool {
        return accepts_deposits
    }
    
    func getOpenHours() -> String {
        return open_hours
    }
    
}
