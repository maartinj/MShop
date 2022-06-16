//
//  ProductCard.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 13/06/2022.
//

import SwiftUI

struct ProductCard: View {
    var product: Product
    
    var animation: Namespace.ID
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            ZStack(alignment: .bottom) {
                
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .matchedGeometryEffect(id: product.image, in: animation)
                    .frame(width: 170)
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(product.name)
                        .font(.system(size: 11))
                        .fontWeight(.semibold)
                    
                    Text(String("\(product.price) zł"))
                        .font(.caption)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .frame(width: 170, height: 50, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180, height: 250)
            .shadow(radius: 3)
            
            Button {
                
                productVM.addToLiked(product: product)
            } label: {
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 13))
                    .foregroundColor(productVM.isLiked(product: product) ? .white : Color.black.opacity(0.7))
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(
                        Color.red.opacity(productVM.isLiked(product: product) ? 1 : 0), in: Circle()
                    )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(7)
        }
        .padding(.top, 20)
    }
}

struct ProductCard_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ProductCard(product: ProductViewModel().MOCK_PRODUCT, animation: namespace)
            .environmentObject(ProductViewModel())
        
    }
}
