//
//  StoryView.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/13.
//

import SwiftUI

struct StoryView: View {
    @EnvironmentObject var vm: StoryViewModel
    
    var body: some View {
        ZStack {
            if vm.showStory {
                TabView(selection: $vm.currentStory) {
                    ForEach($vm.stories) { $bundle in
                        StoryCard(bundle: $bundle)
                            .tag(bundle.id)
                            
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .transition(.move(edge: .bottom))
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
            .environmentObject(StoryViewModel())
    }
}
