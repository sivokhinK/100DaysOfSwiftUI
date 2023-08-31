//
//  ContentView.swift
//  TimeConverter
//
//  Created by Kirill Sivokhin on 31.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTime = 0.0
    @State private var inputUnit = "seconds"
    @State private var outputUnit = "seconds"
    @FocusState private var convertIsFocused: Bool
    
    var convertedTime: Double {
        let seconds: Double
        
        if inputUnit == "minutes" {
            seconds = inputTime * 60
        }
        else if inputUnit == "hours" {
            seconds = inputTime * 60 * 60
        }
        else if inputUnit == "days" {
            seconds = inputTime * 60 * 60 * 24
        }
        else {
            seconds = inputTime
        }
        
        if outputUnit == "minutes" {
            return seconds / 60
        }
        else if outputUnit == "hours" {
            return seconds / 60 / 60
        }
        else if outputUnit == "days" {
            return seconds / 60 / 60 / 24
        }
        else {
            return seconds
        }
    }
    
    let units = ["seconds", "minutes", "hours", "days"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Time 1", value: $inputTime, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($convertIsFocused)
                    
                    Picker("Unit of time", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convert from")
                }
                
                Section {
                    Picker("Unit of time", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(convertedTime, format: .number)
                } header: {
                    Text("Converted")
                }
            }
            .navigationTitle("Time converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        convertIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
