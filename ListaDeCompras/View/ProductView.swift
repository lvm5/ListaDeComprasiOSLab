//
// ProductView.swift
// ListaDeCompras
//
// Created by Paulo Sonzzini Ribeiro de Souza on 28/08/25.
// Modified by Leandro Vansan de Morais on 2025.09.05
//

import SwiftUI

struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var newProductViewIsPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding()
                        .background(Color(.gray.opacity(0.5)))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(viewModel.products) { product in
                        
                        HStack {
                            Text(product.name ?? "Unknown Name")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(product.category.map { String(describing: $0) } ?? "Unknown Category")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("R$ \(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            
                            
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        
                        .swipeActions {
                            Button(role: .destructive) {
                                print("Tentando deletar")
                                viewModel.deleteProduct(product)
                            } label: {
                                Image(systemName: "trash")
                            }
                            // TODO: Update product
                            //                            Button {
                            //                                print("Tentando editar")
                            //                            } label: {
                            //                                Image(systemName: "pencil")
                            //                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Lista de Compras")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        newProductViewIsPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                            .font(.title2)
                    }
                    .accessibilityLabel("Adicionar Novo Produto")
                }
            }
            .sheet(isPresented: $newProductViewIsPresented) {
                NewProductSheetView(viewModel: viewModel)
                    .presentationDetents([.fraction(0.85)])
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
            }
        }
    }
}

#Preview {
    ProductView()
}

