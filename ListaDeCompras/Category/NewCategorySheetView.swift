//
//  NewCategorySheetView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 11/09/25.
//

import SwiftUI

struct NewCategorySheetView: View {
	
	@ObservedObject var viewModel: CategoryViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State var categoryName: String = ""
	
	@State var categoryColor: Color = .white
	
	var body: some View {
		NavigationStack {
			Form {
				HStack {
					
					Text("Nome")
					
					TextField(text: $categoryName) {
						Text("Nome da categoria")
					}
				}
				
				ColorPicker("Cor da Categoria", selection: $categoryColor)
				
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
						viewModel.createCategory(categoryName: categoryName, categoryColor: categoryColor)
						dismiss()
					} label: {
						Image(systemName: "checkmark")
					}
					.disabled(categoryName == "" ? true : false)
				}
			}
			
			.navigationTitle("Nova Categoria")
		}
	}
}

#Preview {
	NewCategorySheetView(viewModel: CategoryViewModel())
}
