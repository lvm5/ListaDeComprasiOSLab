//
//  ProductView.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 28/08/25.
//

import SwiftUI

struct ProductView: View {
	
	@StateObject var viewModel = ProductViewModel()
	
	var body: some View {
		
		Text(viewModel.errorMessage ?? "")
		
		List {
			ForEach(viewModel.products) { product in
				// TODO: Tratar opcional na VM
				Text(product.name ?? "Unknown Name")
			}
		}
		
		Button {
			viewModel.createProduct()
		} label: {
			Image(systemName: "plus.circle.fill")
		}
		
	}
}

#Preview {
	ProductView()
}
