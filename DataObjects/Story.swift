//
//  Story.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

struct Story {
    let id: Int
    let imageName: String
    let title: String
    let description: String

    static let story1 = Story(
        id: 0,
        imageName: "story1",
        title: "Text text text",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )

    static let story2 = Story(
        id: 1,
        imageName: "story2",
        title: "Text text text",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )

    static let story3 = Story(
        id: 2,
        imageName: "story3",
        title: "Text text text",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )
}

extension Story: Identifiable {}

extension Story {
    static let allStories: [Story] = [.story1, .story2, .story3]
}
