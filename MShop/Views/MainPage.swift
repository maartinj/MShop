//
//  MainPage.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

struct MainPage: View {
    
    // Hiding Tab Bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Matched Geometry Effect
    @Namespace var animation
    
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            TabView(selection: $productVM.currentTab) {
                
                Home(animation: animation)
                    .environmentObject(productVM)
                    .applyBackground()
                    .tag(Tab.Home)
                
                LikedView()
                    .environmentObject(productVM)
                    .applyBackground()
                    .tag(Tab.Liked)
                
                CartView()
                    .environmentObject(productVM)
                    .applyBackground()
                    .tag(Tab.Cart)
                
                AboutUsView()
                    .applyBackground()
                    .tag(Tab.AboutUs)
            }
            .overlay(
                
                // Custom Tab Bar
                HStack(spacing: 0) {
                    
                    CustomTabBar(currentTab: $productVM.currentTab)
                }
                    .background(
                        
                        Color.white
                    )
                // Hiding tab bar when details open
                    .offset(y: productVM.showDetails ? 200 : 0)
                
                , alignment: .bottom
            )
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(ProductViewModel())
    }
}

extension View {
    func applyBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .ignoresSafeArea()
            )
    }
}
