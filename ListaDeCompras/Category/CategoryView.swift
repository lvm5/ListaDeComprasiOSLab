//
//  CategoryView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 11/09/25.
//

import SwiftUI

struct CategoryView: View {
	
	@StateObject var viewModel = CategoryViewModel()
	
	@State var newCategorySheetIsPresented: Bool = false
	
	@Environment(\.defaultMinListRowHeight) var listRowHeight
	
	var body: some View {
		NavigationStack {
			
			List {
				ForEach(viewModel.categories) { category in
					HStack {
						Circle()
							.fill(category.color?.stringHexToColor() ?? .white)
							.frame(width: listRowHeight / 1.5)
						
						Text(category.name ?? "Unknown Category")
					}
					.swipeActions {
						Button(role: .destructive) {
							viewModel.deleteCategory(category)
						} label: {
							Image(systemName: "trash")
						}
					}
					
				}
			}
			.sheet(isPresented: $newCategorySheetIsPresented) {
				NewCategorySheetView(viewModel: viewModel)
			}
			
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						newCategorySheetIsPresented.toggle()
					} label: {
						Image(systemName: "plus.circle.fill")
					}

				}
			}
			
			.navigationTitle("Categorias")
		}
		
	}
}

#Preview {
	CategoryView()
}
