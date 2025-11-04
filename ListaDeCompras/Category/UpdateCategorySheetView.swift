//
//  UpdateCategorySheetView.swift
//  ListaDeCompras
//
//  Created by Leandro Vansan de Morais on 2025-10-23.
//

import SwiftUI

struct UpdateCategorySheetView: View {
    
    @ObservedObject var viewModel: CategoryViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var categoryName: String = ""
    @State var categoryColor: Color = .white
    
    var categoryToEdit: CategoryEntity
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Nome")
                    
                    TextField(text: $categoryName) {
                        Text("Alterar nome da categoria")
                    }
                }
                
                ColorPicker("Alterar cor da Categoria", selection: $categoryColor)
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
                        viewModel.updateCategory(categoryToEdit, updateName: categoryName, updateCategoryColor: categoryColor)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(categoryName == "" ? true : false)
                }
            }
            .navigationTitle("Editar Categoria")
        }
    }
}

#Preview {
    let context = DataController.shared.viewContext
    let mockCategory = CategoryEntity(context: context)
    mockCategory.name = "Exemplo Categoria"
    mockCategory.color = "#FFFFFF"
    return UpdateCategorySheetView(viewModel: CategoryViewModel(), categoryToEdit: mockCategory)
}
