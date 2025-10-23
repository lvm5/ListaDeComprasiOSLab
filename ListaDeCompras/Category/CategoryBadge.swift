//
//  CategoryBadge.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 25/09/25.
//

import SwiftUI

struct CategoryBadge: View {
    
    let category: CategoryEntity
    
    var body: some View {
        let backgroundColor = category.color?.stringHexToColor() ?? .white
        
        Text(category.name ?? "Unknown Category")
            .font(.system(size: 9, weight: .bold, design: .monospaced).smallCaps())
            .padding(4)
            .background(backgroundColor)
            .foregroundColor(backgroundColor.contrastTextColor)
            .clipShape(Capsule())
    }
}

//MARK: -  Fórmula de luminância relativa
extension Color {
    func isLight() -> Bool {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = (0.299 * r + 0.587 * g + 0.114 * b)
        return luminance > 0.5
    }
    
    var contrastTextColor: Color {
        isLight() ? .black : .white
    }
}
