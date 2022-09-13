//
//  ContentView.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/12.
//

import SwiftUI

struct ContentView: View {
    @State private var num = 0
    @EnvironmentObject var vm: StoryViewModel
    var body: some View {
        VStack {
            Text("Instagram")
                .font(.largeTitle)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    myProfile
                    ForEach($vm.stories) { $bundle in
                        ProfileVIew(bundle: $bundle)

                    }
    
                    
                    
                }
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $vm.showStory, content: {
            StoryView()
        })
        
//        .overlay(
//            StoryView()
//        )
        
        
        
        
        

    }
    
 

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(StoryViewModel())
    }
}

extension ContentView {
    private var myProfile: some View {
        Button {
            
        } label: {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding(5)
                .overlay(
                    Image(systemName: "plus")
                        .padding(2)
                        .foregroundColor(.white)
                        .background(.blue, in: Circle())
                        .padding(3)
                        .background(.black, in: Circle())
                        .offset(x: 15, y: 15)
                    
                )
            
        }

    }
}
