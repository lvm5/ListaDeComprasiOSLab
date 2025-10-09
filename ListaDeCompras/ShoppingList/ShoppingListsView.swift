//
//  ShoppingListsView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 09/10/25.
//

import Foundation
import SwiftUI

struct ShoppingListsView: View {
	
	@StateObject var viewModel = ShoppingListViewModel()
	
	var body: some View {
		NavigationStack {
			ZStack {
				
				Color("ShoppingListBackground")
					.ignoresSafeArea()
				
				List {
					ForEach(viewModel.shoppingLists) { shoppingList in
						ShoppingListCard(shoppingList: shoppingList)
							.padding(.bottom)
					}
				}
				.scrollContentBackground(.hidden)
				.listStyle(.automatic)
				.background(Color("ShoppingListBackground"))
				
			}
			.navigationTitle("Listas de Compras")
		}
		
	}
}

#Preview {
	ShoppingListsView(viewModel: ShoppingListViewModel())
}

