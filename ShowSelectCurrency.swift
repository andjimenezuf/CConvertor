//
//  ShowSelectCurrency.swift
//  currencyConverter
//
//  Created on 7/31/24.
//
import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: String
    @Binding var bottomCurrency: String
    
    var body: some View {
        ZStack {
            // Background
            Color.brown.opacity(0.1).ignoresSafeArea()
            
            VStack {
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // Top Currency Grid
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(CurrencyData.currencies, id: \.0) { countryCode, currencyCode, currencyName in
                        CurrencyFlag(countryCode: countryCode, currencyName: currencyName)
                            .onTapGesture {
                                topCurrency = currencyCode // Convert to 3-char code
                            }
                    }
                }
                
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                
                // Bottom Currency Grid
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(CurrencyData.currencies, id: \.0) { countryCode, currencyCode, currencyName in
                        CurrencyFlag(countryCode: countryCode, currencyName: currencyName)
                            .onTapGesture {
                                bottomCurrency = currencyCode // Convert to 3-char code
                            }
                    }
                }
                
                // Done Button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.title)
                .padding()
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}
