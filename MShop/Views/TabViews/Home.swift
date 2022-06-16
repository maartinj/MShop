//
//  Home.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 23/05/2022.
//

import SwiftUI

struct Home: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 0) {
                
                // Header View
                HStack(spacing: 0) {
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 25)
                .background(
                    Color.white)
                
                // Title + Custom Corners
                HStack() {
                    
                    Text("Our Products")
                        .font(.title.bold())
                        .padding(.horizontal, 15)
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                .background(
                    Color("Background")
                        .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                )
                
                // Custom Segment Tab
                ScrollView(.vertical, showsIndicators: false) {
                    
                    HStack(spacing: 18) {
                        
                        segmentButton(image: "male-clothes", type: .Male)
                        segmentButton(image: "female-clothes", type: .Female)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(
                        Color("Background"))
                }
                
                // Product View
                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                
                // Grid View
                LazyVGrid(columns: columns, spacing: 18) {
                    
                    // Products
                    ForEach(productVM.filteredProducts) { product in
                        
                        ProductCard(product: product, animation: animation)
                            .onTapGesture {
                                withAnimation {
                                    productVM.currentProduct = product
                                    productVM.showDetails = true
                                }
                            }
                    }
                }
                .background(
                    Color("Background"))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
            )
            // Bottom Tab bar approx padding
            .padding(.bottom, 100)
        }
        // Updating data whenever tab changes
        .onChange(of: productVM.productType) { newValue in
            productVM.filterProductByType()
        }
        .overlay(
            
            ZStack {
                
                // Detail Page
                if let product = productVM.currentProduct, productVM.showDetails {
                    
                    DetailView(product: product, animation: animation)
                        .environmentObject(productVM)
                    
                    // Adding transitions
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
    
    @ViewBuilder
    func segmentButton(image: String, type: ProductType) -> some View {
        
        Button {
            withAnimation {
                productVM.productType = type
            }
        } label: {
            HStack(spacing: 8) {
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                
                Text(type.rawValue)
                    .font(.system(size: 12.5))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                
                ZStack {
                    
                    // Transition Slider
                    if productVM.productType == type {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.8))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                    }
                }
            )
        }
    }
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            MainPage()
        }
    }
}
