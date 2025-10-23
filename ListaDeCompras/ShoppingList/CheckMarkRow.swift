//
//  CheckMarkRow.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 16/10/25.
//

import SwiftUI

struct CheckMarkRow: View {
	
	@Binding var isSelected: Bool
	let product: Product
	
	@Environment(\.defaultMinListRowHeight) var minRowHeight
	
	var body: some View {
		HStack {
			Rectangle()
				.fill(product.category?.color?.stringHexToColor() ?? Color.secondary)
				.frame(width: 10, height: minRowHeight)
				
			
			Toggle(isOn: $isSelected) {
				Text(product.name ?? "Unknown Name")
			}
			
		}
        .padding(.trailing, 16)
	}
}

#Preview {
	let p = Product(context: DataController.shared.viewContext)
	CheckMarkRow(isSelected: .constant(false), product: p)
		.onAppear {
			
		}
}
