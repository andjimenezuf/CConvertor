//  ContentView.swift
//  currencyConverter
//
//  Created on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var showInfo = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    @State var showConverterInfo = false
    @State var showSelectCurrency = false
    @State var leftCurrency = "USD" // Use currency codes for conversion
    @State var rightCurrency = "EUR" // Use currency codes for conversion
   
    @FocusState var leftTyping
    @FocusState var rightTyping

    let currencies = [
        ("US", "US Dollar"),
        ("EU", "Euro"),
        ("GB", "British Pound"),
        ("JP", "Japanese Yen"),
    ]

    var body: some View {
        ZStack {
            Image(.gradient)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.iconCurrency)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                
                Text("Currency Converter")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.yellow)
                
                Spacer().frame(height: 125)
                
                HStack {
                    // Left Conversion
                    VStack {
                        HStack {
                            let leftCountryCode = CurrencyData.getCountryCode(for: leftCurrency)
                            CurrencyFlag(countryCode: leftCountryCode, currencyName: getCurrencyName(for: leftCurrency))
                                .frame(width: 60, height: 70) // Smaller size
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .padding()
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                            .onChange(of: leftAmount) { newValue in
                                if leftTyping {
                                    convertCurrency(from: leftCurrency, to: rightCurrency, amount: newValue) { convertedAmount in
                                        rightAmount = convertedAmount
                                    }
                                }
                            }
                    }
                    
                    Image(systemName: "equal")
                        .font(.title)
                        .foregroundColor(.white)
                        .symbolEffect(.pulse)
                    
                    // Right Conversion
                    VStack {
                        HStack {
                            let rightCountryCode = CurrencyData.getCountryCode(for: rightCurrency)
                            CurrencyFlag(countryCode: rightCountryCode, currencyName: getCurrencyName(for: rightCurrency))
                                .frame(width: 60, height: 70) // Smaller size
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .padding()
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($rightTyping)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .onChange(of: rightAmount) { newValue in
                                if rightTyping {
                                    convertCurrency(from: rightCurrency, to: leftCurrency, amount: newValue) { convertedAmount in
                                        leftAmount = convertedAmount
                                    }
                                }
                            }
                    }
                }
                .padding()
                .background(.black.opacity(0.2))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        showConverterInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                    }
                    .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $showConverterInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                .onChange(of: leftCurrency) { _ in
                    updateConversion()
                }
                .onChange(of: rightCurrency) { _ in
                    updateConversion()
                }
        }
    }
    
    func getCurrencyName(for code: String) -> String {
        currencies.first { $0.1 == code }?.1 ?? code
    }
    
    func convertCurrency(from sourceCurrency: String, to targetCurrency: String, amount: String, completion: @escaping (String) -> Void) {
        guard let amountDouble = Double(amount) else {
            completion("")
            return
        }
        
        Task {
            do {
                let convertedAmount = try await CurrencyConverter.convert(amountDouble, from: sourceCurrency, to: targetCurrency)
                completion(String(format: "%.2f", convertedAmount))
            } catch {
                print("Conversion failed: \(error)")
                completion("Error")
            }
        }
    }
    
    func updateConversion() {
        if leftTyping {
            convertCurrency(from: leftCurrency, to: rightCurrency, amount: leftAmount) { convertedAmount in
                rightAmount = convertedAmount
            }
        } else {
            convertCurrency(from: rightCurrency, to: leftCurrency, amount: rightAmount) { convertedAmount in
                leftAmount = convertedAmount
            }
        }
    }
}

#Preview {
    ContentView()
}
