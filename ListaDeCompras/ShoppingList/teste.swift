//
//  teste.swift
//  ListaDeCompras
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 09/10/25.
//

import SwiftUI

struct teste: View {
	
	@StateObject var controller = Controller()
	
	var body: some View {
		NavigationStack {
			
			VStack {
				NavigationLink {
					// View
					NavigationLink {
						// View
					} label: {
						Text("Terceira View")
					}
					
				} label: {
					Text("Outra View")
				}
				
				
				
				
			}
			.font(.system(size: 100))
		}
		
		VStack {
			Text("\(controller.counter)")
			
			Button {
				controller.counter += 1
			} label: {
				Image(systemName: "plus.circle")
			}
		}.font(.system(size: 100))
	}
}

class Controller: ObservableObject {
	@Published var counter = 0
	
	func increment() {
		print("Counter = \(counter + 1)")
		counter += 1
	}
}

//@State - @StateObject
//@Binding - @ObservedObject


#Preview {
	teste()
}
