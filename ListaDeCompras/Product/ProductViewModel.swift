//
//  ProductViewModel.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 28/08/25.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String? = nil
    @Published var totalProductPrice: Float = 0.0
    
    init() {
        fetchProducts()
        //		populateWithMockProducts()
        calculateTotalProductPrice()
    }
    
    //MARK: - CREATE PRODUCTS
    func createProduct(productName: String, productIntPrice: Int, productCentPrice: Int, productCategory: CategoryEntity) {
        let productPrice: Float = Float(productIntPrice) + (Float(productCentPrice) / 100)
        
        let newProductWrapper = ProductWrapper(name: productName, price: productPrice, category: productCategory)
        
        let result = DataController.shared.createProduct(newProductWrapper) // -> Result<Product, Error>
        
        switch result {
        case .success(let product):
            self.products.append(product)
            calculateTotalProductPrice()
        case .failure(let error):
            self.errorMessage = "Error creating Product: \(error)"
        }
    }
    
    //MARK: - FETCH PRODUCTS
    func fetchProducts() {
        let result = DataController.shared.fetchProducts() // -> Result<[Product], Error>
        
        switch result {
        case .success(let products):
            // TODO: Tratar nomes dos produtos (Identificador primário)
            self.products = products
        case .failure(let error):
            self.errorMessage = "Failed to fetch Products: \(error)"
        }
    }
    
    //MARK: - UPDATE PRODUCTS
    func updateProduct(_ productToUpdate: Product, newName: String, newIntPrice: Int, newCentPrice: Int, newCategory: CategoryEntity) {
        let updatedPrice = Float(newIntPrice) + (Float(newCentPrice) / 100)
        
        let updatedWrapper = ProductWrapper(name: newName, price: updatedPrice, category: newCategory)
        
        let result = DataController.shared.updateProduct(updatedWrapper)
        
        switch result {
        case .success(let updatedProduct):
            
            if let index = self.products.firstIndex(of: productToUpdate) {
                self.products[index] = updatedProduct
            }
            calculateTotalProductPrice()
        case .failure(let error):
            self.errorMessage = "Error update product: \(error)"
        }
    }
    
    //MARK: - DELETE PRODUCTS
    func deleteProduct(_ productToDelete: Product) { // O(n)
        
        products.removeAll { product in
            product == productToDelete
        }
        
        let result = DataController.shared.deleteProduct(productToDelete)
        
        switch result {
        case .success(let productName):
            print("\(productName) deletado com sucesso!")
            calculateTotalProductPrice()
        case .failure(let error):
            self.errorMessage = "Error deleting product: \(error)"
        }
    }
    
    //MARK: - PRICE
    func calculateTotalProductPrice() {
        
        var prices: [Float] = []
        
        products.forEach { product in
            prices.append(product.price)
        }
        
        let sum = prices.reduce(0, +)
        
        self.totalProductPrice = sum
    }
    
    //MARK: - MOCK
    func populateWithMockProducts() {
        let p1 = Product(context: DataController.shared.viewContext)
        p1.name = "Toalhas"
        p1.price = 10
        let p2 = Product(context: DataController.shared.viewContext)
        p2.name = "Fogões"
        p2.price = 10
        let p3 = Product(context: DataController.shared.viewContext)
        p3.name = "Geladeiras"
        p3.price = 10
        
        self.products = [p1, p2, p3]
    }
}
