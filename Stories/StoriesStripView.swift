//
//  StoriesStripView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

struct StoriesStripView: View {
    let stories: [Story]
    @Binding var selectedStory: StorySelection?
    let viewedStories: Set<Int>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                    Button {
                        selectedStory = StorySelection(id: index)
                    } label: {
                        StoryPreviewCell(story: story, isViewed: viewedStories.contains(index) )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

// MARK: - Миниатюра одной сторис
struct StoryPreviewCell: View {
    let story: Story
    let isViewed: Bool

    private let width: CGFloat = 92
    private let height: CGFloat = 140

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .opacity(isViewed ? 0.5 : 1.0)


            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .center,
                endPoint: .bottom
            )

            Text(story.title)
                .font(.system(size: 11))
                .foregroundColor(.white)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .padding(8)
                .opacity(isViewed ? 0.6 : 1.0)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    isViewed ? Color.gray.opacity(0.5) : Color.ypBlue,
                    lineWidth: 4
                )
        )
    }
}
