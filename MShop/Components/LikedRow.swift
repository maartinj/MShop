//
//  LikedRow.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 07/06/2022.
//

import SwiftUI

struct LikedRow: View {
    
    // Making Product as Binding so as to update in real time
    @Binding var product: Product
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(product.name)
                    .font(.system(size: 18).bold())
                    .lineLimit(1)
                
                Text("Size: \(product.size)")
                    .font(.system(size: 17)).bold()
                    .lineLimit(1)
                
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    productVM.removeFromLiked(product: product)
                }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            
            Color("Background")
                .cornerRadius(10)
        )
    }
}

struct LikedRow_Previews: PreviewProvider {
    static var previews: some View {
        LikedRow(product: .constant(ProductViewModel().products[0]))
            .environmentObject(ProductViewModel())
    }
}
