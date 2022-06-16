//
//  ContentView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        NavigationLink(destination: ProductDetails(product: product)) {
                            ProductCard(product: product)
                                .environmentObject(cartManager)
                        }
                        .foregroundColor(.black)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Medical Shop"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
