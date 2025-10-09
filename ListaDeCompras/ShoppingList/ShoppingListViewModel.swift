//
//  ShoppingListViewModel.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 09/10/25.
//

import Foundation

class ShoppingListViewModel: ObservableObject {
	
	@Published var shoppingLists: [ShoppingList] = []
	@Published var errorMessage: String? = nil
	
	init() {
		fetchShoppingLists()
		createMockShoppingLists()
	}
	
	func fetchShoppingLists() {
		let result = DataController.shared.fetchShoppingLists()
		
		switch result {
		case .success(let shoppingLists):
			self.shoppingLists = shoppingLists
		case .failure(let error):
			self.errorMessage = "Failed to fetch shopping lists: \(error)"
		}
	}
	
	func createMockShoppingLists() {
		let list1 = ShoppingList(context: DataController.shared.viewContext)
		let list2 = ShoppingList(context: DataController.shared.viewContext)
		let list3 = ShoppingList(context: DataController.shared.viewContext)
		
		self.shoppingLists = [list1, list2, list3]
	}
}
