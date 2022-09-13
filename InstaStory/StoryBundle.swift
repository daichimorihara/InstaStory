//
//  StoryBundle.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/12.
//

import Foundation

struct StoryBundle: Identifiable,Hashable{
    var id = UUID().uuidString
    var profileName: String
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
}

struct Story: Identifiable,Hashable{
    var id = UUID().uuidString
    var imageURL: String
}
