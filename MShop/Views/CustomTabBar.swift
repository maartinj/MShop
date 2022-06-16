//
//  CustomTabBar.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 23/05/2022.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var currentTab: Tab
    
    // To animate like Curve
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { proxy in
            let width = proxy.size.width
            
            HStack(spacing: 0) {
                
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            currentTab = tab
                            yOffset = -60
                        }
                        // Resetting with slight delay
                        withAnimation(.easeInOut(duration: 0.1).delay(0.07)) {
                            yOffset = 0
                        }
                    } label: {
                        
                        Image(tab.rawValue)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Blue") : .gray)
                        // Little scaling effect
                            .scaleEffect(currentTab == tab && yOffset != 0 ? 1.5 : 1)
                            .badge(5)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(alignment: .leading) {
                Circle()
                    .fill(Color("Orange"))
                    .frame(width: 25, height: 25)
                    .offset(x: 18, y: yOffset)
                    .offset(x: indicatorOffset(width: width))
            }
        }
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
    }
    
    // MARK: Indicator Offset
    func indicatorOffset(width: CGFloat) -> CGFloat {
        let index = CGFloat(getIndex())
        if index == 0 { return 0 }
        
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        
        return index * buttonWidth
    }
    
    func getIndex() -> Int {
        switch currentTab {
        case .Home:
            return 0
        case .Liked:
            return 1
        case .Cart:
            return 2
        case .AboutUs:
            return 3
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
