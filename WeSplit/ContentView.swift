//
//  ContentView.swift
//  WeSplit
//
//  Created by Nusaiba Rahman on 8/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 0
    // should tip amount "have focus", so should is it being modified currently
    // when modifying, it boldens, when done, it fades
    @FocusState private var amountIsFocused: Bool
    
    @State private var numberOfPeople = 0
    var tipPercentages = [0, 10, 15, 18, 20]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100.00 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
        
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(1...10, id: \.self) {
                            Text($0, format: .number)
                        }
                    }

                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip would you like to leave?")
                }
                Section {
                    Text("Check Amount Entered: \(checkAmount) ")
                }
                
                Section {
                    Text("Amount per person: \(totalPerPerson)")
                }
            }  .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
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
