//
// NewProductSheetView.swift
// ListaDeCompras
//
// Created by Paulo Sonzzini Ribeiro de Souza on 04/09/25.
//

import SwiftUI

struct NewProductSheetView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var productName: String = ""
    @State private var productIntPrice: Int = 0
    @State private var productCentPrice: Int = 0
    @State var productCategory: String = ""
    
    private var isFormValid: Bool {
        !productName.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informações do Produto").textCase(.none)) {
                    HStack {
                        TextField("Nome do produto    e", text: $productName)
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .padding(.vertical, 4)
                            .accessibilityLabel("Nome do produto e escolha a categoria")
                        
                        Picker(selection: $productCategory) {
                            ForEach(ProductCategory.allCases) { category in
                                Text(category.id)
                            }
                        } label: {
                            Text(productCategory.isEmpty ? "Categoria" : "")
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section(header: Text("Preço").textCase(.none)) {
                    HStack(spacing: 8) {
                        Text("R$")
                            .foregroundColor(.secondary)
                            .font(.body)
                        
                        Picker("", selection: $productIntPrice) {
                            ForEach(0..<1000) { price in
                                Text("\(price)")
                                    .tag(price)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        .accessibilityLabel("Parte inteira do preço")
                        
                        Text(".")
                            .foregroundColor(.secondary)
                            .font(.body)
                        
                        Picker("", selection: $productCentPrice) {
                            ForEach(0..<100) { price in
                                Text(String(format: "%02d", price))
                                    .tag(price)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        .accessibilityLabel("Centavos do preço")
                    }
                    .padding(.vertical, 8)
                }
                
                Section {
                    HStack(spacing: 16) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancelar")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color(.gray.opacity(0.5)))
                                .cornerRadius(10)
                        }
                        .accessibilityLabel("Cancelar cadastro")
                        
                        Button(action: {
                            viewModel.createProduct(productName: productName,
                                                    productIntPrice: productIntPrice,
                                                    productCentPrice: productCentPrice,
                                                    productCategoryString: productCategory)
                            dismiss()
                        }) {
                            Text("Cadastrar")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(isFormValid ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .accessibilityLabel("Cadastrar produto")
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Novo Produto")
            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar {
            //                ToolbarItem(placement: .cancellationAction) {
            //                    Button("Fechar") {
            //                        dismiss()
            //                    }
            //                    .accessibilityLabel("Fechar formulário")
            //                }
            //            }
        }
    }
}

#Preview {
    NewProductSheetView(viewModel: ProductViewModel())
}

