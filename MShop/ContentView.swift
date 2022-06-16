//
//  ContentView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        // Getting ScreenSize Globally
        GeometryReader { proxy in
            
            let size = proxy.size
            
            WelcomeView(screenSize: size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
