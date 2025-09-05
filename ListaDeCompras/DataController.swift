//
//  DataController.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 21/08/25.
//

import Foundation
import CoreData

final class DataController {
	
	static let shared = DataController()
	
	let persistentContainer: NSPersistentContainer
	
	var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}
	
	private init() {
		persistentContainer = NSPersistentContainer(name: "Models")
		
		persistentContainer.loadPersistentStores { description, error in
			if let error = error {
				print("Core Data failed to load: \(error.localizedDescription)")
			}
		}
		
	}
	
	// Create Read Update Delete
	
	// TODO: Receber os atributos reais
	func createProduct(_ productWrapper: ProductWrapper) -> Result<Product, Error> {
		do {
			let newProduct = Product(context: self.viewContext)
			newProduct.name = productWrapper.name
			newProduct.price = productWrapper.price
			
			try self.viewContext.save()
			
			return .success(newProduct)
		} catch {
			return .failure(error)
		}
	}
	
	
	func fetchProducts() -> Result<[Product], Error> {
		do {
			let productsFetchRequest = NSFetchRequest<Product>(entityName: "Product")
			
			let products = try self.viewContext.fetch(productsFetchRequest)
			
			return .success(products)
		} catch {
			return .failure(error)
		}
	}
	
}

