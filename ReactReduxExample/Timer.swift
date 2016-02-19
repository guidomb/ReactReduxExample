//
//  Timer.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

final class Timer<ActionDispatcher: Dispatcher where ActionDispatcher.Action == RecordSessionAction> {
    
    private let _dispatcher: ActionDispatcher
    private var _timer: NSTimer?
    
    init(dispatcher: ActionDispatcher) {
        self._dispatcher = dispatcher
        self._timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerTick:"), userInfo: nil, repeats: true)
    }
    
    deinit {
        _timer?.finalize()
    }
    
    @objc
    func timerTick(timer: NSTimer) {
        _dispatcher.dispatch(.TimerTick)
    }
    
}