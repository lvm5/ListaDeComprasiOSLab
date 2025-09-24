//
//  ProductCategory.swift
//  ListaDeCompras
//
//  Created by Leandro Vansan de Morais on 18/09/25.
//

import Foundation

enum ProductCategory: String, CaseIterable, Identifiable {
    case Laticinios
    case Bebidas
    case Graos_e_Cereais
    case Carnes
    case Enlatados
    case Embutidos
    case Higiene_pessoal
    case Limpeza
    case Pets
    case Hortifruti
    
    var id: String { rawValue.replacingOccurrences(of: "_", with: " ") }
    
    
}
