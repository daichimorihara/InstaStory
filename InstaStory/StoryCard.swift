//
//  StoryCard.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/13.
//

import SwiftUI

struct StoryCard: View {
    @Binding var bundle: StoryBundle
    @EnvironmentObject var vm: StoryViewModel
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var timeProgress: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            baseImage
                .overlay(
                    totchEffect
                )
                .overlay(
                    profileBar,
                    alignment: .top
                )
                .overlay(
                    HStack(spacing: 5) {
                        progressBar
                    }
                    .padding(.horizontal)
                    ,alignment: .top
                )
                .rotation3DEffect(getAngle(proxy: proxy),
                                  axis: (0,1,0),
                                  anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                                  perspective: 1)
                .onReceive(timer, perform: { _ in
                    if vm.currentStory == bundle.id {
                        if !bundle.isSeen {
                            bundle.isSeen = true
                        }
                        
                        if timeProgress < CGFloat(bundle.stories.count) {
                            if getAngle(proxy: proxy).degrees == 0 {
                                timeProgress += 0.03
                            }
                        } else {
                            //update story forward
                            updateStory()
                        }
                    }
                })
                .onAppear {
                    timeProgress = 0
                }
            
                
            
        }
        .background(.black)
    }
}

struct StoryCard_Previews: PreviewProvider {
    static var previews: some View {
        StoryCard(bundle: .constant(
            StoryBundle(
profileName: "Jenna Ezarik",
profileImage: "Pic2",
isSeen: true,
stories: [
Story(imageURL: "post4"),
Story(imageURL: "post5"),
])
        ))
        .environmentObject(StoryViewModel())
    }
}

extension StoryCard {
    private var baseImage: some View {
        ZStack {
            let index = min(Int(timeProgress), bundle.stories.count - 1)
            if let story = bundle.stories[index] {
                Image(story.imageURL)
                    .resizable()
                    .scaledToFit()
                    
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private var totchEffect: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(.black.opacity(0.01))
                .onTapGesture {
                    if timeProgress < 1 {
                        // updateStory backward
                        updateStory(forward: false)
                    } else {
                        timeProgress = CGFloat(Int(timeProgress - 1))
                    }
                }
            
            
            Rectangle()
                .fill(.black.opacity(0.01))
                .onTapGesture {
                    if CGFloat(bundle.stories.count - 1) < timeProgress {
                        // updateStory forward
                        updateStory()
                    } else {
                        timeProgress = CGFloat(Int(timeProgress + 1))
                    }
                }
        }
    }
    
    private var profileBar: some View {
        HStack(spacing: 10) {
            Image(bundle.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            
            Text(bundle.profileName)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                withAnimation {
                    vm.showStory = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .padding(.leading)
    }
    
    private var progressBar: some View {
        ForEach(bundle.stories.indices) { index in
            GeometryReader { proxy in
                let width = proxy.size.width
                let progress = timeProgress - CGFloat(index)
                let percentage = min(1, max(0, progress))
                
                Capsule()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 1.4)
                    .overlay(
                        Capsule()
                            .fill(.white)
                            .frame(width: width * percentage)
                        ,alignment: .leading
                    )
            }
        }
    }
    
    func getAngle(proxy: GeometryProxy)->Angle{
        
        // converting Offset into 45 Deg rotation...
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        
        let rotationAngle: CGFloat = 45
        let degrees = rotationAngle * progress
        
        return Angle(degrees: Double(degrees))
    }

    func updateStory(forward: Bool = true) {
        let index = min(Int(timeProgress), bundle.stories.count - 1)
        let story = bundle.stories[index]
        
        if !forward {
            if let firstBundle = vm.stories.first,
               firstBundle.id != bundle.id {
                let bundleIndex = vm.stories.firstIndex(where: { $0.id == bundle.id }) ?? 0
                withAnimation {
                    vm.currentStory = vm.stories[bundleIndex - 1].id
                }
                
            } else {
                timeProgress = 0
            }
            return
        }
        
        if let last = bundle.stories.last, last.id == story.id
        {
            if let lastBundle = vm.stories.last,
               lastBundle.id == bundle.id {
                withAnimation {
                    vm.showStory = false
                }
            } else {
                let bundleIndex = vm.stories.firstIndex(where: {$0.id == bundle.id}) ?? 0
                withAnimation {
                    vm.currentStory = vm.stories[bundleIndex + 1].id
                }
            }
        }
        

        
    }
}
