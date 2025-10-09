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
}
