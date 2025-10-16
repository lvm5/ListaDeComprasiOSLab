//
//  NewShoppingListView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 16/10/25.
//

import SwiftUI

struct NewShoppingListView: View {
	
	@Environment(\.dismiss) private var dismiss
	
	@StateObject var productViewModel = ProductViewModel()
	@ObservedObject var viewModel: ShoppingListViewModel
	
	@State var shoppingListName: String = ""
	@State var shoppingListDate: Date = Date.now
	@State var shoppingListTotalCost: Float = 0
	
	@State var selectedProducts: [Product] = []
	
	var body: some View {
		NavigationStack {
			VStack {
				Form {
					TextField("", text: $shoppingListName, prompt: Text("Nome da lista de compras"))
					
					DatePicker("Data da compra", selection: $shoppingListDate)
					Text("Preço total calculado: R$\(String(format: "%.2f", shoppingListTotalCost))")
				}
				.scrollDisabled(true)
				.frame(height: UIScreen.main.bounds.height / 4.5)
				
				Text("Produtos da Lista")
					.font(.largeTitle)
					.fontWeight(.semibold)
				
				ScrollView {
					ForEach(productViewModel.products) { product in
						let isSelectedBinding = Binding<Bool>(
							get: { selectedProducts.contains(where: { $0.id == product.id } ) },
							set: { newValue in
								if newValue {
									selectedProducts.append(product)
								} else {
									selectedProducts.removeAll(where: { $0.id == product.id } )
								}
								shoppingListTotalCost = selectedProducts.reduce(0) { $0 + $1.price }
							}
						)
						
						CheckMarkRow(isSelected: isSelectedBinding, product: product)
						
						Divider()
					}
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button {
						dismiss()
					} label: {
						Image(systemName: "xmark")
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button {
						let wrapper = ShoppingListWrapper(date: shoppingListDate, name: shoppingListName, totalCost: shoppingListTotalCost, products: selectedProducts)
						
						viewModel.createShoppingList(with: wrapper)
					} label: {
						Image(systemName: "checkmark")
					}
					.disabled(shoppingListName == "" || selectedProducts.isEmpty)
				}
			}
			.navigationTitle("Nova Lista de Compras")
		}
	}
}

#Preview {
	NewShoppingListView(viewModel: ShoppingListViewModel())
}
