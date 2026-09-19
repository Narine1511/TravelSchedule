//
//  ContentStoryView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

struct ContentStoryView: View {
    let stories: [Story]
    let initialIndex: Int
    let onStoryViewed: (Int) -> Void

    @Environment(\.dismiss) private var dismiss

    init(
        stories: [Story],
        initialIndex: Int = 0,
        onStoryViewed: @escaping (Int) -> Void = { _ in }
    ) {
        self.stories = stories
        self.initialIndex = initialIndex
        self.onStoryViewed = onStoryViewed
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(
                stories: stories,
                initialIndex: initialIndex,
                onStoryViewed: onStoryViewed
            )
            .id(initialIndex)
            CloseButton(action: {
                dismiss()
            })
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
    }
}
