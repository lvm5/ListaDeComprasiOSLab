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
	
	init(name: String, price: Float) {
		self.name = name
		
		if price < 0 {
			self.price = 0.0
		} else {
			self.price = price
		}
		
	}
}
