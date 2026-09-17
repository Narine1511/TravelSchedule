import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories) { story in
                StoryView(story: story)
                    .tag(story.id) 
                    .overlay(tapZones)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    func didTapStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
    
    private var tapZones: some View {
            HStack(spacing: 0) {
                Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { goToPrevious() }
                Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { goToNext() }
                        }
}
    private func goToPrevious() {
            guard currentStoryIndex > 0 else { return }
            currentStoryIndex -= 1
        }
        
        private func goToNext() {
            guard currentStoryIndex < stories.count - 1 else { return }
            currentStoryIndex += 1
        }
    }
