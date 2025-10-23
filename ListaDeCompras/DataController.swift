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
	
	static func seedIfNeeded(container: NSPersistentContainer) async throws {
		
		try await container.performBackgroundTask { context in
			let req = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
			req.resultType = .countResultType
			let count = try context.count(for: req)
			
			guard count == 0 else { return }
			
			let categoryBebidas = CategoryEntity(context: context)
			let categoryLaticinios = CategoryEntity(context: context)
			
			categoryBebidas.name = "Bebidas"
			categoryBebidas.color = "#0f2bdb"
			
			categoryLaticinios.name = "Laticinios"
			categoryLaticinios.color = "#faf7f7"
			
			if context.hasChanges {
				try context.save()
			}
		}
	}
	
	// Create Read Update Delete
	// TODO: Receber os atributos reais
    
    //MARK: - CREATE PRODUCT
	func createProduct(_ productWrapper: ProductWrapper) -> Result<Product, Error> {
		do {
			
			let newProduct = Product(context: self.viewContext)
			newProduct.name = productWrapper.name
			newProduct.price = productWrapper.price
			newProduct.category = productWrapper.category
			
			productWrapper.category.addToProducts(newProduct)
			
			try self.viewContext.save()
			
			return .success(newProduct)
		} catch {
			return .failure(error)
		}
	}
	
    //MARK: - FETCH PRODUCT
	func fetchProducts() -> Result<[Product], Error> {
		do {
			let productsFetchRequest = NSFetchRequest<Product>(entityName: "Product")
			
			let products = try self.viewContext.fetch(productsFetchRequest)
			
			return .success(products)
		} catch {
			return .failure(error)
		}
	}
    
    //MARK: - UPDATE PRODUCT
    func updateProduct(_ productWrapper: ProductWrapper) -> Result<Product, Error> {
        do {
            let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
            fetchRequest.predicate = NSPredicate(format: "name == %@", productWrapper.name)

            if let productToUpdate = try self.viewContext.fetch(fetchRequest).first {
                productToUpdate.price = productWrapper.price
                productToUpdate.category = productWrapper.category
                productWrapper.category.addToProducts(productToUpdate)

                try self.viewContext.save()

                return .success(productToUpdate)
            } else {
                // Produto não encontrado, pode criar ou retornar erro
                return .failure(NSError(domain: "UpdateProduct", code: 404, userInfo: [NSLocalizedDescriptionKey: "Product not found"]))
            }
        } catch {
            return .failure(error)
        }
    }

    //MARK: - DELETE PRODUCT
	func deleteProduct(_ productToDelete: Product) -> Result<String, Error> {
		do {
			let productName = productToDelete.name ?? "Unknown Product"
			
			self.viewContext.delete(productToDelete)
			try self.viewContext.save()
			
			return .success(productName)
		} catch {
			return .failure(error)
		}
	}
	
    //MARK: - CREATE CATEGORY
    func createCategory(_ categoryWrapper: CategoryWrapper) -> Result<CategoryEntity, Error> {
		
		do {
			let newCategory = CategoryEntity(context: self.viewContext)
			newCategory.name = categoryWrapper.name
			newCategory.color = categoryWrapper.color
			
			try self.viewContext.save()
			
			return .success(newCategory)
		} catch {
			return .failure(error)
		}
		
	}
	
    //MARK: - FETCH CATEGORY
	func fetchCategories() -> Result<[CategoryEntity], Error> {
		let fetchRequest = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
		
		do {
			let result = try self.viewContext.fetch(fetchRequest)
			
			return .success(result)
		} catch {
			return .failure(error)
		}
	}
	
    //MARK: - UPDATE CATEGORY
    func updateCategory(_ categoryWrapper: CategoryWrapper) -> Result<CategoryEntity, Error> {
        do {
            let fetchRequest = NSFetchRequest<CategoryEntity>(entityName: "Category")
            fetchRequest.predicate = NSPredicate(format: "name == %@", categoryWrapper.name)

            if let categoryToUpdate = try self.viewContext.fetch(fetchRequest).first {
                categoryToUpdate.name = categoryWrapper.name
                categoryToUpdate.color = categoryWrapper.color

                try self.viewContext.save()

                return .success(categoryToUpdate)
            } else {
                // Category não encontrada, pode criar ou retornar erro
                return .failure(NSError(domain: "UpdateCategory", code: 404, userInfo: [NSLocalizedDescriptionKey: "Category not found"]))
            }
        } catch {
            return .failure(error)
        }
    }
    
    //MARK: - DELETE CATEGORY
	func deleteCategory(_ categoryToDelete: CategoryEntity) -> Result<String, Error> {
		do {
			let categoryName = categoryToDelete.name ?? "Unknown Category"
			
			self.viewContext.delete(categoryToDelete)
			try self.viewContext.save()
			
			return .success(categoryName)
		} catch {
			return .failure(error)
		}
	}
	
    //MARK: - CREATE SHOPPING LIST
	func createShoppingList(_ shoppingListWrapper: ShoppingListWrapper) -> Result<ShoppingList, Error> {
		let newShoppingList = ShoppingList(context: self.viewContext)
		
		newShoppingList.date = shoppingListWrapper.date
		newShoppingList.name = shoppingListWrapper.name
		newShoppingList.totalCost = shoppingListWrapper.totalCost
		
		shoppingListWrapper.products.forEach { product in
			product.addToShoppingList(newShoppingList)
			newShoppingList.addToProducts(product)
		}
		
		do {
			try viewContext.save()
			
			return .success(newShoppingList)
		} catch {
			return .failure(error)
		}
	}
		
    //MARK: - FETCH SHOPPING LIST
	func fetchShoppingLists() -> Result<[ShoppingList], Error> {
		
		let fetchRequest = NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
		
		do {
			let result = try viewContext.fetch(fetchRequest)
			
			return .success(result)
		} catch {
			return .failure(error)
		}
	}
	
}
