//
//  NewProductSheetView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 04/09/25.
//

import SwiftUI

struct NewProductSheetView: View {
	
	@ObservedObject var viewModel: ProductViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State var productName: String = ""
	@State var productIntPrice: Int = 0
	@State var productCentPrice: Int = 0
	@State var productCategory: String = "Bebidas"
	
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
					ForEach(ProductCategory.allCases) { category in
						Text(category.id)
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
				
				Section {
					HStack {
						Spacer()
						Button {
							viewModel.createProduct(productName: productName, productIntPrice: productIntPrice, productCentPrice: productCentPrice, productCategoryString: productCategory)
							dismiss()
						} label: {
							Text("Cadastrar")
						}
						.disabled(productName == "" ? true : false)
						Spacer()
					}
				}
				
				Section {
					HStack {
						Spacer()
						Button {
							dismiss()
						} label: {
							Text("Cancelar")
								.foregroundStyle(.red)
								.bold()
						}
						Spacer()
					}
				}
			}
			.navigationTitle("Novo Produto")
		}
		
		
	}
}

#Preview {
	NewProductSheetView(viewModel: ProductViewModel())
}
