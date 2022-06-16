//
//  DetailView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 25/05/2022.
//

import SwiftUI

struct DetailView: View {
    var product: Product
    
    // For Hero Effect
    var animation: Namespace.ID
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                Button {
                    
                    withAnimation(.easeInOut) {
                        productVM.showDetails = false
                    }
                } label: {
                    
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    
                    productVM.addToLiked(product: product)
                } label: {
                    
                    Image(systemName: "heart.fill")
                        .padding(8)
                        .font(.system(size: 22))
                        .foregroundColor(productVM.isLiked(product: product) ? .white : Color.black.opacity(0.7))
                        .background(
                            
                            Color.red.opacity(productVM.isLiked(product: product) ? 1 : 0), in: Circle()
                        )
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.bottom)
            
            // Clothes image
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            // Add matched geometry before frame()
                .matchedGeometryEffect(id: product.image, in: animation)
                .frame(height: getScreenBounds().height / 3)
                .padding(.vertical, 30)
            
            // Product details
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    
                    Text(product.name)
                        .font(.title2.bold())
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                        
                        Spacer()
                        
                        Text(product.description)
                            .font(.callout)
                            .lineSpacing(10)
                    }
                }
                
                // Size
                HStack(spacing: 0) {
                    
                    Text("Size: ")
                        .font(.caption.bold())
                        .foregroundColor(.gray)
                        .padding(.trailing)
                    
                    Button {
                        
                    } label: {
                        
                        Text(product.size)
                            .font(.callout)
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.orange)
                                    .opacity(0.3)
                            )
                    }
                }
                .padding(.vertical)
                
                // Add to Cart
                Button {
                    
                    productVM.addingToCart(product: product)
                } label: {
                    
                    HStack(spacing: 15) {
                        
                        Image("cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                        Text("\(productVM.isAddedToCart(product: product) ? "Added" : "Add") to Cart")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color("Blue"))
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Blue").opacity(0.06))
                    .clipShape(Capsule())
                }
                .padding(.top)
            }
            .padding(.top)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                Color(.white)
                    .opacity(0.85)
                    .cornerRadius(20)
                    .ignoresSafeArea(.container, edges: .bottom)
            )
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("Background"))
        .transition(.opacity)
        .padding(.top, 25)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Extending View to get screen Bounds
extension View {
    
    func getScreenBounds() -> CGRect {
        
        return UIScreen.main.bounds.integral
    }
}
