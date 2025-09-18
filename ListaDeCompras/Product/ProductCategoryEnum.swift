//
//  ProductCategoryEnum.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 11/09/25.
//

import Foundation

enum ProductCategory: String, CaseIterable, Identifiable {
	case Bebidas
	case Laticinios
	case Carnes
	case Limpeza
	case Higiene_Pessoal
	case Enlatados
	case Embutidos
	case Pets
	case Graos_e_Cereais
	case Hortifruti
	
	var id: String { rawValue.replacingOccurrences(of: "_", with: " ") }
}
