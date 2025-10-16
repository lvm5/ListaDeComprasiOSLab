//
//  CategoryViewModel.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 11/09/25.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
	
	@Published var categories: [CategoryEntity] = []
	@Published var errorMessage: String? = nil
	
	init() {
		fetchCategories()
	}
	
	func createCategory(categoryName: String, categoryColor: Color) {
		
		let newCategory = CategoryWrapper(name: categoryName, color: categoryColor.toHexString())
		
		let result = DataController.shared.createCategory(newCategory)
		
		switch result {
		case .success(let category):
			self.categories.append(category)
		case .failure(let error):
			self.errorMessage = "Failed to create Category: \(error)"
		}
	}
	
	func fetchCategories() {
		let result = DataController.shared.fetchCategories()
		
		switch result {
		case .success(let categories):
			self.categories = categories
		case .failure(let error):
			self.errorMessage = "Failed to fetch Products: \(error)"
		}
	}
	
	func deleteCategory(_ categoryToDelete: CategoryEntity) {
		
		categories.removeAll { category in
			category == categoryToDelete
		}
		
		let result = DataController.shared.deleteCategory(categoryToDelete)
		
		switch result {
		case .success(let categoryName):
			print("\(categoryName) deletado com sucesso!")
		case .failure(let error):
			self.errorMessage = "Error deleting category: \(error)"
		}
	}
	
}




