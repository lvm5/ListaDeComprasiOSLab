//
//  ListaDeComprasApp.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 21/08/25.
//

import SwiftUI

@main
struct ListaDeComprasApp: App {
	var body: some Scene {
		WindowGroup {
			TabView {
				ProductView()
					.tabItem {
						Label {
							Text("Produtos")
						} icon: {
							Image(systemName: "basket.fill")
						}
					}
				
				CategoryView()
					.tabItem {
						Label {
							Text("Categorias")
						} icon: {
							Image(systemName: "tag.fill")
						}
					}
			}
		}
	}
}
