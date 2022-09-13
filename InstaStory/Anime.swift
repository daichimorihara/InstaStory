//
//  Anime.swift
//  InstaStory
//
//  Created by Daichi Morihara on 2022/09/12.
//

import SwiftUI

struct Anime: View {
    @State private var index = 0
    var body: some View {
        TabView(selection: $index) {
            ForEach(0..<5, id: \.self) { num in
                GeometryReader { proxy in
                    ZStack {
                        LinearGradient(colors: [.black, .blue], startPoint: .leading, endPoint: .trailing)
                        Capsule()
                            .foregroundColor(.white)

                        
                        
                    }
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .rotation3DEffect(getAngle(proxy: proxy),
                                      axis: (0, 1, 0),
                                      anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                                      perspective: 1)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
    
    func getAngle(proxy: GeometryProxy)->Angle{
        
        // converting Offset into 45 Deg rotation...
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        
        let rotationAngle: CGFloat = 45
        let degrees = rotationAngle * progress
        
        return Angle(degrees: Double(degrees))
    }
}

struct Anime_Previews: PreviewProvider {
    static var previews: some View {
        Anime()
    }
}
