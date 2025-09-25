//
//  CategoryBadge.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 25/09/25.
//

import SwiftUI

struct CategoryBadge: View {
	
	let category: CategoryEntity
	
	var body: some View {
		
		Text(category.name ?? "Unknown Category")
			.font(.system(size: 10, weight: .bold))
			.padding(4)
			.background {
				category.color?.stringHexToColor() ?? .white
			}
			.clipShape(RoundedRectangle(cornerRadius: 5))
		
	}
}
