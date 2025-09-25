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

	init() {
		fetchProducts()
	}
	
	func createProduct(productName: String, productIntPrice: Int, productCentPrice: Int, productCategory: CategoryEntity) {
		let productPrice: Float = Float(productIntPrice) + (Float(productCentPrice) / 100)
		
		let newProductWrapper = ProductWrapper(name: productName, price: productPrice, category: productCategory)
		
		let result = DataController.shared.createProduct(newProductWrapper) // -> Result<Product, Error>
		
		switch result {
		case .success(let product):
			self.products.append(product)
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
		case .failure(let error):
			self.errorMessage = "Error deleting product: \(error)"
		}
	}
}
