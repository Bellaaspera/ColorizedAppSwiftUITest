//
//  ContentView.swift
//  ColorizedAppSwiftUITest
//
//  Created by Светлана Сенаторова on 03.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueVAlue = Double.random(in: 0...255)
    
    @FocusState var focusedField: Field?
    
    var body: some View {
        
        ZStack {
            Color.blue.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 320, height: 160)
                    .foregroundColor(getColor())
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 6))
                VStack {
                    SliderView(value: $redValue, color: Color.red)
                        .focused($focusedField, equals: .red)
                    SliderView(value: $greenValue, color: Color.green)
                        .focused($focusedField, equals: .green)
                    SliderView(value: $blueVAlue, color: Color.blue)
                        .focused($focusedField, equals: .blue)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: {previouseField(field: focusedField ?? .red)}) {
                            Image(systemName: "chevron.up")
                        }
                        Button(action: {nextField(field: focusedField ?? .red)}) {
                            Image(systemName: "chevron.down")
                        }
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .padding()
        }
    }
    
    private func getColor() -> Color {
        let red = redValue/255
        let green = greenValue/255
        let blue = blueVAlue/255
        let color = Color(red: red, green: green, blue: blue)
        return color
    }
    
    private func nextField(field: Field) {
        switch field {
        case .red:
            focusedField = .green
        case .green:
            focusedField = .blue
        case .blue:
            focusedField = .red
        case .none:
            focusedField = nil
        }
    }
    
    private func previouseField(field: Field) {
        switch field {
        case .red:
            focusedField = .blue
        case .green:
            focusedField = .red
        case .blue:
            focusedField = .green
        case .none:
            focusedField = nil
        }
    }
    
}

enum Field {
    case red, green, blue, none
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
