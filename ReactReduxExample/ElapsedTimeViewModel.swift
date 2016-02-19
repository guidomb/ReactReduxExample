//
//  ElapsedTimeViewModel.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation

struct ElapsedTimeViewModel {
    
    let elapsedTime: Int
    let formattedElapsedTime: String
    
    var title: String {
        return "elapsed time"
    }
    
    init(elapsedTime: Int = 0) {
        self.elapsedTime = elapsedTime
        self.formattedElapsedTime = formatDurationIntoHoursMinutesSeconds(elapsedTime)
    }
    
}

extension ElapsedTimeViewModel: Equatable { }

func ==(lhs: ElapsedTimeViewModel, rhs: ElapsedTimeViewModel) -> Bool {
    return lhs.elapsedTime == rhs.elapsedTime
}

private typealias Hours = Int
private typealias Minutes = Int
private typealias Seconds = Int

private func formatDurationIntoHoursMinutesSeconds(seconds: Int) -> String {
    let (hours, minutes, seconds) = decomposeSeconds(seconds)
    var time: String = ""
    
    if hours < 10 {
        time += "0\(hours):"
    } else {
        time += "\(hours):"
    }
    if minutes < 10 {
        time += "0\(minutes):"
    } else {
        time += "\(minutes):"
    }
    if seconds < 10 {
        time += "0\(seconds)"
    } else {
        time += "\(seconds)"
    }
    return time
}

private func decomposeSeconds(seconds: Int) -> (Hours, Minutes, Seconds) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}