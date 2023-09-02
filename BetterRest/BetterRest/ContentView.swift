//
//  ContentView.swift
//  BetterRest
//
//  Created by Kirill Sivokhin on 02.09.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
//    @State private var sleepTime = Date.now
    
    var sleepTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            return wakeUp - prediction.actualSleep
            //            alertTitle = "Your ideal bedtime is..."
            //            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
        
        return Date.now
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section(header: Text("Desired amound of sleep")) {
                    Stepper("\(sleepAmount.formatted()) of hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section(header: Text("Daily coffee intake")) {
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    
                    Picker("Amount of cups", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("You shoul wake up at this time")) {
                    Text("\(sleepTime.formatted(date: .omitted, time: .shortened))")
                        .fontWeight(.heavy)
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
//    func calculateBedtime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            sleepTime = wakeUp - prediction.actualSleep
////            alertTitle = "Your ideal bedtime is..."
////            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//            showingAlert = true
//        }
//
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
