//
//  SliderView.swift
//  ColorizedAppSwiftUITest
//
//  Created by Светлана Сенаторова on 03.07.2023.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    @State private var textFieldText = ""
    @State private var alertPresented: Bool = false
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(Color.white)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    textFieldText = lround(newValue).formatted()
                }
            TextField("\(lround(value))", text: $textFieldText, onEditingChanged: { _ in
                withAnimation {
                    checkValue()
                }
            })
                .onAppear() {
                    textFieldText = lround(value).formatted()
                }
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .keyboardType(.decimalPad)
                .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                    Text("Please enter a number in 0...255")
                }
        }
    }
    
    private func checkValue() {
        if let text = Int(textFieldText), (0...255).contains(text) {
            value = Double(text)
            return
        } else {
            alertPresented.toggle()
            textFieldText = "0"
            value = 0
        }
    }
        
}
struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(50), color: Color.red)
    }
}
