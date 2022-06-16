//
//  WelcomeView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 11/06/2022.
//

import SwiftUI

// To use the custom font on all pages
let customFont = "Montserrat-Regular"

struct WelcomeView: View {
    
    // Showing Main Page
    @State var isMain: Bool = false
    
    var screenSize: CGSize
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    
                } label: {
                    
                    Image("logo2")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                // Skip button
                Button("Skip") {
                    withAnimation {
                        
                        isMain = true
                    }
                }
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color("Blue"))
                .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            OffsetPageTabView(offset: $offset) {
                
                HStack(spacing: 0) {
                    
                    ForEach(intros) { intro in
                        
                        VStack {
                            
                            Image(intro.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: screenSize.height / 3)
                            
                            VStack(alignment: .leading, spacing: 22) {
                                
                                Text(intro.title)
                                    .font(.largeTitle.bold())
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text(intro.description)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                    .padding(.top, 25)
                                // Extra padding for background color
                                    .padding(.bottom, 150)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .foregroundColor(Color("Blue"))
                            .padding(.top, 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        // Extra padding for background color
                        .padding(.top, 120)
                        // Setting max Width
                        .frame(width: screenSize.width)
                    }
                }
                .background(.white)
            }
            
            // Animated Indicator
            HStack(alignment: .bottom) {
                
                // Indicators
                HStack(spacing: 12) {
                    
                    ForEach(intros.indices, id: \.self) { index in
                        
                        Capsule()
                            .fill(Color("Blue"))
                        // Increaasing width for only current index
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                        
                    }
                }
                .overlay (
                    
                    Capsule()
                        .fill(Color("Blue"))
                        .frame(width: 20, height: 7)
                        .offset(x: getIndicatorOffset())
                    
                    ,alignment: .leading
                )
                .offset(x: 10, y: -15)
                
                Spacer()
                
                Button {
                    
                    // Updating offset
                    let index = min(getIndex() + 1, intros.count - 1)
                    
                    offset = CGFloat(index) * screenSize.width
                } label: {
                    
                    Image(systemName: "chevron.right")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(20)
                        .background(
                            
                            intros[getIndex()].color, in: Circle()
                        )
                }
            }
            .padding()
            .offset(y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
        
        .overlay(
            
            Group {
                if isMain {
                    MainPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
        
        // Animating when index changes
        .animation(.easeInOut, value: getIndex())
    }
    
    // Expanding index based on offset
    func getIndex() -> Int {
        
        let progress = round(offset / screenSize.width)
        
        // For Safety
        let index = min(Int(progress), intros.count - 1)
        
        return index
    }
    
    // Offset for indicator
    func getIndicatorOffset() -> CGFloat {
        
        let progress = offset / screenSize.width
        
        // 12 = spacing
        // 7 = Circle size
        
        let maxWidth: CGFloat = 12 + 7
        
        return progress * maxWidth
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")
    }
}
