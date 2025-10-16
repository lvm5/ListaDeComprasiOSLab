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
		createMockShoppingLists()
		fetchShoppingLists()
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
	
	func createShoppingList(with wrapper: ShoppingListWrapper) {
		let result = DataController.shared.createShoppingList(wrapper)
		
		switch result {
		case .success(let shoppingList):
			self.shoppingLists.append(shoppingList)
		case .failure(let error):
			self.errorMessage = "Failed to create Shopping List: \(error)"
		}
	}
	
	func createMockShoppingLists() {
		let list1 = ShoppingList(context: DataController.shared.viewContext)
		let list2 = ShoppingList(context: DataController.shared.viewContext)
		let list3 = ShoppingList(context: DataController.shared.viewContext)
		
		self.shoppingLists = [list1, list2, list3]
	}
}
