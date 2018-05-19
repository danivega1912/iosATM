//
//  AtmAnnotationView.swift
//  iosATM
//
//  Created by Daniel Vega on 5/18/18.
//  Copyright © 2018 Daniel Vega. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AttractionAnnotationView: MKAnnotationView {
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard let attractionAnnotation = self.annotation as? MKPinAnnotationView else { return }
        
        //image = attractionAnnotation.type.image()
    }
}
