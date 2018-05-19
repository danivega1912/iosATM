//
//  ColorPinAnnotation.swift
//  iosATM
//
//  Created by Daniel Vega on 5/18/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//
import MapKit

class CustomPinAnnotation : MKPointAnnotation {
    var id:Int
    var pinColor:UIColor
    var pinCallOutImage:UIImage
    var pinText:String
    
    init(id:Int, pinColor: UIColor, pinImage: UIImage, pinText: String) {
        self.id = id
        self.pinColor = pinColor
        self.pinCallOutImage = pinImage
        self.pinText = pinText
        super.init()
    }
}
