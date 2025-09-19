//
//  ProductView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 28/08/25.
//

import SwiftUI

struct ProductView: View {
	
	@StateObject var viewModel = ProductViewModel()
	
	@State var newProductViewIsPresented: Bool = false
	
	var body: some View {
		NavigationStack {
			Text(viewModel.errorMessage ?? "")
			
			List {
				ForEach(viewModel.products) { product in
					// TODO: Tratar opcional na VM
					HStack {
						Text(product.name ?? "Unknown Name")
						Spacer()
						Text("R$\(product.price, specifier: "%.2f")")
					}
					
					.swipeActions {
						Button(role: .destructive) {
							viewModel.deleteProduct(product)
						} label: {
							Image(systemName: "trash")
						}
					}
				}

				
			}
			.sheet(isPresented: $newProductViewIsPresented) {
				NewProductSheetView(viewModel: viewModel)
					.interactiveDismissDisabled()
					.presentationDetents([.fraction(0.70)])
			}
			
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						newProductViewIsPresented.toggle()
					} label: {
						Image(systemName: "plus.circle.fill")
					}
				}
			}
			.navigationTitle("Produtos")
		}
		
	}
}

#Preview {
	ProductView()
}
