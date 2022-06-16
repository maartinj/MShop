//
//  ProductViewModel.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 19/05/2022.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    
    // Cart Products
    @Published var cartProducts: [Product] = []
    
    // Liked Products
    @Published var likedProducts: [Product] = []
    
    // Filtered Products
    @Published var filteredProducts: [Product] = []
    
    // Tab Bar
    @Published var currentTab: Tab = .Home
    
    // Product Type
    @Published var productType: ProductType = .Male
    
    // Detail View Properties
    @Published var currentProduct: Product?
    @Published var showDetails = false
    
    // Products to calculate
    @Published var productsToCalculate: [Product] = []
    
    // Total Price
    @Published private(set) var total: Double = 0
    
    init() {
        filterProductByType()
    }
    
    // Sample Products
    @Published var products: [Product] = [
        Product(type: .Male, name: "T-shirt white", description: "A classic cut makes this organic cotton blend t-shirt an elegant element in a layered outfit.\n\nComposition and care:\n50% organic cotton, 50% cotton", image: "tshirt-white-man", price: 49.99, size: "L"),
        Product(type: .Male, name: "T-shirt green", description: "If you want to draw attention to your outfit, wear this pure organic cotton jersey T-shirt in a bold color.\n\nComposition and care:\n100% organic cotton", image: "tshirt-green-man", price: 59.99, size: "XL"),
        Product(type: .Male, name: "T-shirt grey", description: "This airy t-shirt will add style to your casual outfits.\n\nComposition and care:\n50% organic cotton, 50% cotton", image: "tshirt-grey-man", price: 49.99, size: "M"),
        Product(type: .Male, name: "Hoodie brown", description: "A hoodie over the head, made of elastic knit from a blend of organic cotton, is a simple patent for comfortable styling while relaxing.\n\nComposition and care:\n64% organic cotton, 36% recycled polyester", image: "hoodie-brown-man", price: 159.99, size: "L"),
        Product(type: .Female, name: "T-shirt white", description: "Complete your everyday transitional wardrobe with this pure organic cotton jersey t-shirt.\n\nComposition and care:\n100% organic cotton", image: "tshirt-white-woman", price: 39.99, size: "M"),
        Product(type: .Female, name: "T-shirt brown", description: "Tight cut emphasizing the silhouette - this T-shirt will be an elegant accent of everyday stylizations.\n\nComposition and care:\n60% organic cotton, 40% polyester", image: "tshirt-brown-woman", price: 49.99, size: "XL"),
        Product(type: .Female, name: "Hoodie pink", description: "Discover the classic sports design and enjoy its richness by composing stylizations for the pitch and the city. This oversized, round neck sweatshirt is embellished with an iconic color.\n\nComposition and care:\n80% cotton, 20% polyester", image: "hoodie-pink-woman", price: 199.99, size: "L"),
        Product(type: .Female, name: "Hoodie green", description: "A slightly dropped shoulder line and ribbing lend this pure organic cotton sweatshirt a casual character.\n\nComposition and care:\n100% organic cotton", image: "hoodie-green-woman", price: 129.99, size: "S"),
    ]
    
    let MOCK_PRODUCT = Product(type: .Male, name: "T-shirt biały męski rozmiar L", description: "A classic cut makes this organic cotton blend t-shirt an elegant element in a layered outfit.\n\nComposition and care:\n50% organic cotton, 50% cotton", image: "tshirt-white-man", price: 49.99, size: "L")
    
    func addtoCart(product: Product) {
        productsToCalculate.append(product)
        total += product.price
    }
    
    func addingToCart(product: Product) {
        
        if let index = productsToCalculate.firstIndex(where: { cartProduct in
            
            return product.id == cartProduct.id
        }){
            
            // Remove from Cart
            productsToCalculate.remove(at: index)
            total -= product.price
            
        } else {
            
            // Add to Cart
            productsToCalculate.append(product)
            total += product.price
        }
    }
    
    func isAddedToCart(product: Product) -> Bool {
        
        return productsToCalculate.contains { cartProduct in
            return product.id == cartProduct.id
        }
    }
    
    func removeFromCart(product: Product) {
        
        let _ = withAnimation {
            
            // Removing
            productsToCalculate = productsToCalculate.filter { $0.id != product.id }
            total -= product.price
        }
    }
    
    // Calculating Total Price
    func getTotalPrice() -> String {
        
        var total: Double = 0
        
        productsToCalculate.forEach { product in
            
            let price = product.price
            let quantity = product.quantity
            let priceTotal = Double(quantity) * price
            
            total += priceTotal
        }
        
        return "\(String(format: "%.2f", total)) zł"
    }
    
    func isLiked(product: Product) -> Bool {
        
        return likedProducts.contains { likedProduct in
            return product.id == likedProduct.id
        }
    }
    
    func addToLiked(product: Product) {
        
        if let index = likedProducts.firstIndex(where: { likedProduct in
            
            return product.id == likedProduct.id
        }){
            
            // Remove from Liked
            likedProducts.remove(at: index)
        } else {
            
            // Add to Liked
            likedProducts.append(product)
        }
    }
    
    func removeFromLiked(product: Product) {
        
        let _ = withAnimation {
            
            // Removing
            likedProducts = likedProducts.filter { $0.id != product.id }
        }
    }
    
    func filterProductByType() {
        
        // Filtering product by Product Type
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so using lazy to perform more
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap( { product in
                    return product
                })
            }
        }
    }
}
