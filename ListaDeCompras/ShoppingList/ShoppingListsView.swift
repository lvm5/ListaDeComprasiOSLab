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
				
				ScrollView {
					
					NavigationLink {
						NewShoppingListView(viewModel: viewModel)
					} label: {
						HStack {
							Spacer()
							Image(systemName: "plus")
								.foregroundStyle(.white)
							Spacer()
						}
						.frame(height: 25)
						.padding()
						.background(
							Color.secondary.opacity(0.7)
								.clipShape(RoundedRectangle(cornerRadius: 15))
						)
						.padding(.horizontal)
						.padding(.vertical)
					}
					
					ForEach(viewModel.shoppingLists.sorted { $0.date ?? Date.now.advanced(by: 1000000) > $1.date ?? Date.now.advanced(by: 1000000) }) { shoppingList in
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

