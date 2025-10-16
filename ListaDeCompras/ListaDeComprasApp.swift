//
//  ListaDeComprasApp.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 21/08/25.
//

import SwiftUI

@main
struct ListaDeComprasApp: App {
	
	let dataController = DataController.shared
	@AppStorage("didSeed") private var didSeed: Bool = false
	
	@State var currentView = "ShoppingListView"
	
	var body: some Scene {
		WindowGroup {
			TabView(selection: $currentView) {
				ProductView()
					.tabItem {
						Label {
							Text("Produtos")
						} icon: {
							Image(systemName: "basket.fill")
						}
					}
					.tag("ProductView")
				
				ShoppingListsView()
					.tabItem {
						Label {
							Text("Listas")
						} icon: {
							Image(systemName: "list.bullet.rectangle.portrait.fill")
						}
					}
					.tag("ShoppingListView")
				
				CategoryView()
					.tabItem {
						Label {
							Text("Categorias")
						} icon: {
							Image(systemName: "tag.fill")
						}
					}
					.tag("CategoryView")
				
			}
			.task {
				if !didSeed {
					do {
						try await DataController.seedIfNeeded(container: dataController.persistentContainer)
						didSeed = true
					} catch {
						print("Seed failed: \(error)")
					}
				}
			}
		}
	}
}
