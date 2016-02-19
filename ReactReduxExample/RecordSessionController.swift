//
//  ViewController.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/17/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit
import Neon


final class RecordSessionController: ContainerComponent {

    private let _mapView = SessionMapView()
    private let _buttonsView = RecordButtonBarComponent()
    private let _distanceView = DistanceComponent()
    private let _elapsedTimeView = ElapsedTimeComponent()
    
    var state: RecordSessionState {
        didSet {
            bindState()
        }
    }
    
    init(state: RecordSessionState = RecordSessionState()) {
        self.state = state
        super.init(renderables: [
            _mapView,
            _buttonsView,
            _distanceView,
            _elapsedTimeView
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func performStateBinding() {
        _mapView.properties = state.path
        _elapsedTimeView.elapsedTime = state.elapsedTime
    }
    
    override func applySubviewsLayout() {
        _mapView.anchorAndFillEdge(.Top, xPad: 0, yPad: 0, otherSize: view.height * 0.5)
        
        _elapsedTimeView.align(.UnderCentered, relativeTo: _mapView, padding: 0, width: view.width, height: view.height * (7 / 32))
        
        _distanceView.align(.UnderCentered, relativeTo: _elapsedTimeView, padding: 0, width: view.width, height: view.height * (7 / 32))
        
        _buttonsView.anchorAndFillEdge(.Bottom, xPad: 0, yPad: 0, otherSize: view.height * (1.0 / 16.0))
    }
    
}

