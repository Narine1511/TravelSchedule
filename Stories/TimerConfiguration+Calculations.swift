//
//  TimerConfiguration+Calculations.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

extension TimerConfiguration {
    func progress(for storyIndex: Int) -> CGFloat {
        return min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }

    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
}
