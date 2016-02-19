//
//  SessionMapView.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit
import MapKit

final class SessionMapView: MKMapView, Component {
    
    var properties: [Coordinate] {
        didSet {
            if shouldUpdate(oldValue) {
                render()
            }
        }
    }
    
    init(properties: [Coordinate] = []) {
        self.properties = properties
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
    }
    
    func shouldUpdate(properties: [Coordinate]) -> Bool {
        return self.properties != properties
    }

}