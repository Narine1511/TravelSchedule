//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//


import SwiftUI

struct StoriesView: View {
    let stories: [Story]
    let initialIndex: Int
    let onStoryViewed: (Int) -> Void
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0

    init(stories: [Story], initialIndex: Int = 0, onStoryViewed: @escaping (Int) -> Void = { _ in }) {
            self.stories = stories
            self.initialIndex = initialIndex
        self.onStoryViewed = onStoryViewed
            _currentStoryIndex = State(initialValue: initialIndex)
        }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                    onStoryViewed(newValue)
                }

            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
                
            }
        }
        .onAppear {
            currentStoryIndex = initialIndex
                    currentProgress = timerConfiguration.progress(for: initialIndex)

            onStoryViewed(initialIndex)
                    }
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}
