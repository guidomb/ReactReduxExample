//
//  RecordSessionState.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/17/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

final class RecordSessionState {
    
    let recordingState: RecordingState
    let elapsedTime: Int
    let distance: Float
    let path: [Coordinate]
    
    init(recordingState: RecordingState = .Idle, elapsedTime: Int = 0, distance: Float = 0.0, path: [Coordinate] = []) {
        self.recordingState = recordingState
        self.elapsedTime = elapsedTime
        self.distance = distance
        self.path = path
    }
    
    func update(recordingState recordingState: RecordingState? = Optional.None, elapsedTime: Int? = Optional.None, distance: Float? = Optional.None, path: [Coordinate]?  = Optional.None) -> RecordSessionState {
        return RecordSessionState(
            recordingState: recordingState ?? .Idle,
            elapsedTime: elapsedTime ?? self.elapsedTime,
            distance: distance ?? self.distance,
            path: path ?? self.path)
    }
    
    func incrementElapsedTime() -> RecordSessionState {
        return update(elapsedTime: self.elapsedTime + 1)
    }
    
}