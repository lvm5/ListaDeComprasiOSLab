//
//  ShoppingListCard.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 09/10/25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ShoppingListCard: View {
    
    let shoppingList: ShoppingList
    @State private var viewModel = ShoppingListViewModel()
    
    var body: some View {
        
        HStack {
            
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            } else {
                Button {
                    showImagePickerOptions()
                } label: {
                    VStack {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Adicionar Foto")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            
            VStack(alignment: .leading) {
                Text(shoppingList.name ?? "Shopping List Name")
                    .bold()
                
                Text("R$\(String(format: "%.2f", shoppingList.totalCost))")
                    .font(.subheadline)
                    .foregroundStyle(Color("PrimaryColor"))
                
                Spacer()
                
                Text("\(shoppingList.date ?? Date.now)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("ShoppingListCardBackground"))
        )
        .frame(width: UIScreen.main.bounds.width - 50, height: 125)
    }
    
    // MARK: - Função auxiliar
    func showImagePickerOptions() {
        let alert = UIAlertController(title: "Adicionar Imagem", message: "Escolha uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Câmera", style: .default) { _ in
            viewModel.showCamera = true
        })
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default) { _ in
            viewModel.showPhotoPicker = true
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        // Apresenta o alert no UIWindow principal
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(alert, animated: true)
        }
    }
    
}

//extension ShoppingListCard {
//    // MARK: - Função auxiliar
//    func showImagePickerOptions() {
//        let alert = UIAlertController(title: "Adicionar Imagem", message: "Escolha uma opção", preferredStyle: .actionSheet)
//        
//        alert.addAction(UIAlertAction(title: "Câmera", style: .default) { _ in
//            viewModel.showCamera = true
//        })
//        
//        alert.addAction(UIAlertAction(title: "Galeria", style: .default) { _ in
//            viewModel.showPhotoPicker = true
//        })
//        
//        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
//        
//        // Apresenta o alert no UIWindow principal
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let root = scene.windows.first?.rootViewController {
//            root.present(alert, animated: true)
//        }
//    }
//}



#Preview {
    ShoppingListCard(shoppingList: ShoppingList(context: DataController.shared.viewContext))
}
