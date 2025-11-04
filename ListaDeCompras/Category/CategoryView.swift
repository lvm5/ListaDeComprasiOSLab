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
    @State private var categoryToEdit: CategoryEntity? = nil
    @State var updateCategorySheetIsPresented: Bool = false
    @State private var editCategorySheetIsPresented: Bool = false

    
    @Environment(\.defaultMinListRowHeight) var listRowHeight
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(viewModel.categories) { category in
                    HStack {
                        Circle()
                            .fill(category.color?.stringHexToColor() ?? .white)
                            .frame(width: listRowHeight / 1.5)
                            .padding(.trailing, 8)
                        
                        Text(category.name ?? "Unknown Category")
                    }
                    .swipeActions {
     
                        Button(role: .destructive) {
                            viewModel.deleteCategory(category)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button {
                            categoryToEdit = category
                            updateCategorySheetIsPresented = true
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
            .sheet(isPresented: $newCategorySheetIsPresented) {
                NewCategorySheetView(viewModel: viewModel)
            }
            
            .sheet(item: $categoryToEdit) { editingCategory in
                UpdateCategorySheetView(viewModel: viewModel, categoryToEdit: editingCategory)
                    .interactiveDismissDisabled()
                    .presentationDetents([.fraction(0.70)])
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
