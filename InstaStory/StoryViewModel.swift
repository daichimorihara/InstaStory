//
//  StoryViewModel.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/13.
//

import Foundation

class StoryViewModel: ObservableObject {
    @Published var stories : [StoryBundle] = [
    
        StoryBundle(profileName: "iJustine", profileImage: "Pic1", stories: [
        
            Story(imageURL: "post1"),
            Story(imageURL: "post2"),
            Story(imageURL: "post3"),
        ]),
        
        StoryBundle(profileName: "Jenna Ezarik", profileImage: "Pic2", stories: [
        
            Story(imageURL: "post4"),
            Story(imageURL: "post5"),
        ])
    ]
    
    @Published var showStory: Bool = false
    @Published var currentStory: String = ""
}
