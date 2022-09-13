//
//  ProfileVIew.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/13.
//

import SwiftUI

struct ProfileVIew: View {
    @Binding var bundle: StoryBundle
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var vm: StoryViewModel
    
    var body: some View {
        Image(bundle.profileImage)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(2)
            .background(scheme == .dark ? .black : .white, in: Circle())
            .overlay(
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray)
                    .opacity(bundle.isSeen ? 1 : 0)
                
            )
            .padding(3)
            .background(
                LinearGradient(colors: [
                
                    .red,
                    .orange,
                    .red,
                    .orange
                ],
                startPoint: .top,
                endPoint: .bottom)
                .clipShape(Circle())
                .opacity(bundle.isSeen ? 0 : 1)
            )
            .onTapGesture {
                bundle.isSeen = true
                vm.currentStory = bundle.id
                vm.showStory = true
            }
  
        
    }
}

struct ProfileVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVIew(bundle: .constant(
            StoryBundle(
profileName: "Jenna Ezarik",
profileImage: "Pic2",
isSeen: true,
stories: [
Story(imageURL: "post4"),
Story(imageURL: "post5"),
])
        )

                        )
        .environmentObject(StoryViewModel())
    }
}
