//
//  ShoppingListCard.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 09/10/25.
//

import Foundation
import SwiftUI

struct ShoppingListCard: View {
	
	let shoppingList: ShoppingList
	
	var body: some View {
		
		HStack {
			Image("Camera2")
				.resizable()
				.scaledToFill()
				.frame(width: 100, height: 100)
				.clipped()
				
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
//		.shadow(radius: 10)
	}
	
}

#Preview {
	ShoppingListCard(shoppingList: ShoppingList(context: DataController.shared.viewContext))
}
