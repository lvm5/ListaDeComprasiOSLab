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
    @State private var productToEdit: Product? = nil
    @State private var editProductSheetIsPresented: Bool = false
    
    @Environment(\.defaultMinListRowHeight) private var listRowHeight
    
    var body: some View {
        NavigationStack {
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
            
            List {
                ForEach(viewModel.products) { product in
                    // TODO: Tratar opcional na VM
                    HStack {
                        
                        Text(product.name ?? "Unknown Name")
                        CategoryBadge(category: product.category!)
                        
                        Spacer()
                        Text("R$\(product.price, specifier: "%.2f")")
                    }
                    
                    .swipeActions {

                        Button(role: .destructive) {
                            viewModel.deleteProduct(product)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button {
                            productToEdit = product
                            editProductSheetIsPresented = true
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
                
            }
            
            Text("Total - R$\(viewModel.totalProductPrice, specifier: "%.2f")")
                .font(.title)
            
                .sheet(isPresented: $newProductViewIsPresented) {
                    NewProductSheetView(viewModel: viewModel)
                        .interactiveDismissDisabled()
                        .presentationDetents([.fraction(0.70)])
                }
            
                .sheet(item: $productToEdit) { editingProduct in
                    UpdateProductSheetView(viewModel: viewModel, productToEdit: editingProduct)
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
