//
//  CategoryViewModel.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 11/09/25.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
	
	@Published var categories: [CategoryEntity] = []
	@Published var errorMessage: String? = nil
	
	init() {
		fetchCategories()
	}
	
	func createCategory(categoryName: String, categoryColor: Color) {
		
		let newCategory = CategoryWrapper(name: categoryName, color: categoryColor.toHexString())
		
		let result = DataController.shared.createCategory(newCategory)
		
		switch result {
		case .success(let category):
			self.categories.append(category)
		case .failure(let error):
			self.errorMessage = "Failed to create Category: \(error)"
		}
	}
	
	func fetchCategories() {
		let result = DataController.shared.fetchCategories()
		
		switch result {
		case .success(let categories):
			self.categories = categories
		case .failure(let error):
			self.errorMessage = "Failed to fetch Products: \(error)"
		}
	}
	
	func deleteCategory(_ categoryToDelete: CategoryEntity) {
		
		categories.removeAll { category in
			category == categoryToDelete
		}
		
		let result = DataController.shared.deleteCategory(categoryToDelete)
		
		switch result {
		case .success(let categoryName):
			print("\(categoryName) deletado com sucesso!")
		case .failure(let error):
			self.errorMessage = "Error deleting category: \(error)"
		}
	}
	
}

extension Color {
	
	func toHexString() -> String {
		let uiColor = UIColor(self)
		
		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0
		
		uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
		
		let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
		return String(format: "#%06x", rgb)
	}
	
}

extension String {
	
	func stringHexToColor() -> Color {
		let hex = self
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.replacingOccurrences(of: "#", with: "")
			.uppercased()
		
		func makeColor(r: UInt8, g: UInt8, b: UInt8, a: UInt8) -> Color {
			Color(.sRGB,
					red:   Double(r) / 255.0,
					green: Double(g) / 255.0,
					blue:  Double(b) / 255.0,
					opacity: Double(a) / 255.0)
		}
		
		switch hex.count {
		case 3: // RGB (4-bit each) -> expand to 8-bit
			let r = hex[hex.startIndex]
			let g = hex[hex.index(hex.startIndex, offsetBy: 1)]
			let b = hex[hex.index(hex.startIndex, offsetBy: 2)]
			let rr = UInt8(String([r, r]), radix: 16)
			let gg = UInt8(String([g, g]), radix: 16)
			let bb = UInt8(String([b, b]), radix: 16)
			if let r = rr, let g = gg, let b = bb { return makeColor(r: r, g: g, b: b, a: 255) }
			
		case 4: // RGBA (4-bit each) -> expand to 8-bit
			let r = hex[hex.startIndex]
			let g = hex[hex.index(hex.startIndex, offsetBy: 1)]
			let b = hex[hex.index(hex.startIndex, offsetBy: 2)]
			let a = hex[hex.index(hex.startIndex, offsetBy: 3)]
			let rr = UInt8(String([r, r]), radix: 16)
			let gg = UInt8(String([g, g]), radix: 16)
			let bb = UInt8(String([b, b]), radix: 16)
			let aa = UInt8(String([a, a]), radix: 16)
			if let r = rr, let g = gg, let b = bb, let a = aa { return makeColor(r: r, g: g, b: b, a: a) }
			
		case 6: // RRGGBB (8-bit each)
			var value: UInt64 = 0
			if Scanner(string: hex).scanHexInt64(&value) {
				let r = UInt8((value & 0xFF0000) >> 16)
				let g = UInt8((value & 0x00FF00) >> 8)
				let b = UInt8(value & 0x0000FF)
				return makeColor(r: r, g: g, b: b, a: 255)
			}
			
		case 8: // RRGGBBAA (8-bit each)
			var value: UInt64 = 0
			if Scanner(string: hex).scanHexInt64(&value) {
				let r = UInt8((value & 0xFF000000) >> 24)
				let g = UInt8((value & 0x00FF0000) >> 16)
				let b = UInt8((value & 0x0000FF00) >> 8)
				let a = UInt8(value & 0x000000FF)
				return makeColor(r: r, g: g, b: b, a: a)
			}
			
		default:
			break
		}
		
		return .white
	}
}
