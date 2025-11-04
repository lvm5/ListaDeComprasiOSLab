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
	
    //MARK: - CREATE CATEGORY
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
    
    //MARK: - FETCH CATEGORY
	func fetchCategories() {
		let result = DataController.shared.fetchCategories()
		
		switch result {
		case .success(let categories):
			self.categories = categories
		case .failure(let error):
			self.errorMessage = "Failed to fetch Products: \(error)"
		}
	}
	
    //MARK: - UPDATE PRODUCTS
    func updateCategory(_ categoryToUpdate: CategoryEntity, updateName: String, updateCategoryColor: Color) {
        
        categoryToUpdate.name = updateName
        categoryToUpdate.color = updateCategoryColor.toHexString()
        
        do {
            try DataController.shared.viewContext.save()
            if let index = categories.firstIndex(where: { $0 == categoryToUpdate }) {
                categories[index] = categoryToUpdate
            }
            print("\(categoryToUpdate) editado com sucesso!")
        } catch {
            self.errorMessage = "Error update product: \(error)"
        }
    }
    
    
    //MARK: - DELETE CATEGORY
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

