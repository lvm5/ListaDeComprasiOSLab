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
	
	@State var allProductsList: [Product] = []
	
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
					if !productViewModel.products.isEmpty {
						ForEach(allProductsList) { product in
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
					} else {
						Text("Não há produtos cadastrados")
					}
				}
                .scrollIndicators(.hidden)
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
						
						dismiss()
					} label: {
						Image(systemName: "checkmark")
					}
					.disabled(shoppingListName == "" || selectedProducts.isEmpty)
				}
			}
			.navigationTitle("Nova Lista de Compras")
		}
		.onAppear {
			allProductsList = productViewModel.products.sorted { ($0.category?.name ?? "") < ($1.category?.name ?? "") }
		}
	}
}

#Preview {
	NewShoppingListView(viewModel: ShoppingListViewModel())
}
