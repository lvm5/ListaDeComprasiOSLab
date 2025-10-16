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
	
	func calculateTotalProductPrice() {
		
		var prices: [Float] = []
		
		products.forEach { product in
			prices.append(product.price)
		}
		
		let sum = prices.reduce(0, +)
		
		self.totalProductPrice = sum
	}
	
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
