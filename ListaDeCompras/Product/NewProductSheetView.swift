//
//  NewProductSheetView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 04/09/25.
//

import SwiftUI

struct NewProductSheetView: View {
	
	@StateObject var categoryViewModel = CategoryViewModel()
	@ObservedObject var viewModel: ProductViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State var productName: String = ""
	@State var productIntPrice: Int = 0
	@State var productCentPrice: Int = 0
	@State var productCategory: CategoryEntity? = nil
	
	var body: some View {
		NavigationStack {
			Form {
				HStack {
					
					Text("Nome")
					
					TextField(text: $productName) {
						Text("Nome do produto")
					}

				}
				
				Picker(selection: $productCategory) {
					ForEach(categoryViewModel.categories, id:\.name) { category in
						Text(category.name ?? "Unknown Category")
							.tag(category)
					}
					.onAppear {
						self.productCategory = self.categoryViewModel.categories.first
					}
				} label: {
					Text("Categoria")
				}
				
				VStack(alignment: .leading) {
					Text("Preço")
						.font(.title)
					
					HStack {
						
						Text("R$")
						
						Picker(selection: $productIntPrice) {
							ForEach(0..<1000) { price in
								Text("\(price)")
							}
						} label: {
							Text("Preço do produto")
						}
						.pickerStyle(.wheel)
						
						Text(".")
						
						Picker(selection: $productCentPrice) {
							ForEach(0..<100) { price in
								Text("\(price)")
							}
						} label: {
							Text("")
						}
						.pickerStyle(.wheel)
						
						
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
						viewModel.createProduct(productName: productName, productIntPrice: productIntPrice, productCentPrice: productCentPrice, productCategory: productCategory!)
						dismiss()
					} label: {
						Image(systemName: "checkmark")
					}
					.disabled(productName == "" ? true : false)
				}
			}
			
			.navigationTitle("Novo Produto")
		}
		
		
	}
}

#Preview {
	NewProductSheetView(viewModel: ProductViewModel())
}
