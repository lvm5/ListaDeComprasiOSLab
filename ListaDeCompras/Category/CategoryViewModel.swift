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
		
		let newCategory = CategoryWrapper(name: categoryName, color: <#T##String#>)
		
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
	
	func deleteCategory() {
		
	}
	
}
