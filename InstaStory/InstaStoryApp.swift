//
//  InstaStoryApp.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/12.
//

import SwiftUI

@main
struct InstaStoryApp: App {
    @StateObject var vm = StoryViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
