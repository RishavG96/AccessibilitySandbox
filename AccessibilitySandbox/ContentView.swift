//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Rishav Gupta on 25/06/23.
//

import SwiftUI

struct ContentView: View {
    
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tuplips",
        "Frozen treebuds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var value = 10
    
    var body: some View {
        VStack {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
            
            Image(decorative: "character") // only there for decoration, will hide it from voice over
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .accessibilityHidden(true) // if users cant see it visually, then hide it from voice over
            
            Group {
                Text("Value: \(value)")
                
                Button("Increment") {
                    value += 1
                }
                
                Button("Decrement") {
                    value -= 1
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Value")
            .accessibilityValue(String(value))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not Handled")
                }
            }
        }
//        .accessibilityElement(children: .combine) // Read all the children together
        .accessibilityElement(children: .ignore) // Read all the children together
        .accessibilityLabel("Your Image is character of anime") // Dont read the children, read the label instead
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
