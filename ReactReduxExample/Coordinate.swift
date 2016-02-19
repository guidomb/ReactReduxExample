//
//  Coordinate.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

struct Coordinate {
    
    let latitude: Double
    let longitude: Double
    
}

extension Coordinate: Equatable { }

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}