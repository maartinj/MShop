//
//  CartView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    HStack {
                        
                        Text("Shopping list")
                            .font(.system(size: 28).bold())
                        
                        Spacer()
                    }
                    
                    // Checking if cart list is empty
                    if productVM.productsToCalculate.count > 0 {
                        
                        // Displaying Products
                        VStack(spacing: 15) {
                            
                            ForEach($productVM.productsToCalculate, id: \.id) { $product in
                                
                                HStack(spacing: 0) {
                                    
                                    ProductRow(product: $product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    } else {
                        
                        Group {
                            Image("NoBasket")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("Clothes not added yet?")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Go to Home Page and hit the product that You want to buy.")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding()
            }
            
            // Showing Total and Check Out button
            if productVM.productsToCalculate.count > 0 {
                
                Group {
                    
                    HStack {
                        
                        Text("Total")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(productVM.getTotalPrice())
                            .font(.system(size: 18).bold())
                            .foregroundColor(.blue)
                    }
                    
                    Button {
                        
                    } label: {
                        
                        Text("Checkout")
                            .font(.system(size: 18).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    }
                    .padding(.bottom, 100)
                }
                .padding(.horizontal, 25)
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            
            Color.white
                .ignoresSafeArea()
        )
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ProductViewModel())
    }
}
