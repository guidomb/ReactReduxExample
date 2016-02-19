//
//  RecordSessionStore.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

enum RecordSessionAction {
    case TimerTick
    case GPSPositionUpdate(coordinate: Coordinate, timestamp: NSTimeInterval)
    case StartRecording
    case StopRecording
    case ContinueRecording
    case SaveSession
}

final class RecordSessionStore: Store<RecordSessionAction, RecordSessionState> {

    init() {
        super.init(initialState: RecordSessionState()) { state, action in
            switch action {
            case .GPSPositionUpdate(let coordinate, _):
                var newPath = state.path
                newPath.append(coordinate)
                return state.update(path: newPath)
            case .TimerTick:
                return state.incrementElapsedTime()
            case .StartRecording:
                return state.update(recordingState: .Recording)
            case .StopRecording:
                return state.update(recordingState: .Paused)
            case .SaveSession:
                return state.update(recordingState: .Idle)
            case .ContinueRecording:
                return state.update(recordingState: .Recording)
            }
        }
    }
    
}