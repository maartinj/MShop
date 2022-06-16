//
//  LikedView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 01/06/2022.
//

import SwiftUI

struct LikedView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                HStack {
                    
                    Text("Liked list")
                        .font(.system(size: 28).bold())
                    
                    Spacer()
                }
                
                // Checking if liked list is empty
                if productVM.likedProducts.isEmpty {
                    
                    Group {
                        Image("NoLiked")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
                            .padding(.top, 35)
                        
                        Text("Not liked yet?")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                        
                        Text("Hit the heart button on each product page to save the top ones.")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    
                    // Displaying Liked products
                    VStack(spacing: 15) {
                        
                        ForEach($productVM.likedProducts) { $product in
                            
                            HStack(spacing: 0) {
                                
                                LikedRow(product: $product)
                            }
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            
            Color.white
                .ignoresSafeArea()
        )
    }
}

struct LikedView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
            .environmentObject(ProductViewModel())
    }
}
