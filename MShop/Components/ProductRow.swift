//
//  ProductRow.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

struct ProductRow: View {
    
    // Making Product as Binding so as to update in real time
    @Binding var product: Product
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(spacing: 0) {
                    
                    Text(product.name)
                        .font(.system(size: 17)).bold()
                        .lineLimit(1)
                    
                    Text("; size: \(product.size)")
                        .font(.system(size: 17)).bold()
                        .lineLimit(1)
                }
                
                // Quantity buttons
                HStack(spacing: 10) {
                    
                    Text("Quantity")
                        .font(.system(size: 14))
                        .foregroundColor(Color("Blue"))
                    
                    Button {
                        
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Blue"))
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        
                        product.quantity += 1
                    } label: {
                        
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Blue"))
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    productVM.removeFromCart(product: product)
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

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: .constant(ProductViewModel().products[0]))
            .environmentObject(ProductViewModel())
    }
}
