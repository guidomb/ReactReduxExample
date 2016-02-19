//
//  DistanceViewModel.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

struct DistanceViewModel {
    
    let distance: Float
    let formattedDistance: String
    
    var title: String {
        return "distance"
    }
    
    init(distance: Float = 0.0) {
        self.distance = distance
        self.formattedDistance = "\(distance) km"
    }
    
}

extension DistanceViewModel: Equatable { }

func ==(lhs: DistanceViewModel, rhs: DistanceViewModel) -> Bool {
    return lhs.distance == rhs.distance
}
