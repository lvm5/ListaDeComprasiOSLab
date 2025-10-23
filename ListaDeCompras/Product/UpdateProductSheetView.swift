//
//  UpdateProductSheetView.swift
//  ListaDeCompras
//
//  Created by Leandro Vansan de Morais on 2025-10-23.
//

import SwiftUI

struct UpdateProductSheetView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel()
    @ObservedObject var viewModel: ProductViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var productName: String = ""
    @State var productIntPrice: Int = 0
    @State var productCentPrice: Int = 0
    @State var productCategory: CategoryEntity? = nil
    
    var productToEdit: Product
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    
                    Text("Nome")
                    
                    TextField(text: $productName) {
                        Text("Alterar nome do produto")
                    }
                    
                }
                
                Picker(selection: $productCategory) {
                    ForEach(categoryViewModel.categories, id:\.name) { category in
                        CategoryBadge(category: category)
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
                        viewModel.updateProduct(productToEdit, newName: productName, newIntPrice: productIntPrice, newCentPrice: productCentPrice, newCategory: productCategory!)
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
    let context = DataController.shared.viewContext
    let mockCategory = CategoryEntity(context: context)
    mockCategory.name = "Exemplo Categoria"
    mockCategory.color = "#FFFFFF"
    let mockProduct = Product(context: context)
    mockProduct.name = "Exemplo Produto"
    mockProduct.price = 0.0
    mockProduct.category = mockCategory
    return UpdateProductSheetView(viewModel: ProductViewModel(), productToEdit: mockProduct)
}
