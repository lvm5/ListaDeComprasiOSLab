//
//  ProductWrapper.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 04/09/25.
//

import Foundation

struct ProductWrapper {
	let name: String
	let price: Float
	let category: ProductCategory
	
	init(name: String, price: Float, category: ProductCategory) {
		self.name = name
		self.category = category
		
		if price < 0 {
			self.price = 0.0
		} else {
			self.price = price
		}
		
	}
}
