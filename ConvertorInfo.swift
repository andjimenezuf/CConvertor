//
//  ConvertorInfo.swift
//  LOTRConverter17
//
//  Created on 6/23/24.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            //baground parchement image
            Image(.gradient)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack{
                //Title Text
                Text("Welcome to Currency Converter!")
                    .font(.largeTitle)
                    .tracking(3)// changes spacing between letters
                    .foregroundColor(.yellow)
                
                //Desciption text
                Text("""
                Key Features:

                - **Real-time Exchange Rates:** We use the ExchangeRateAPI to provide up-to-date exchange rates for accurate conversions.
                - **Automatic Conversion:** The app automatically calculates and displays the converted amount as you type, ensuring you always have the latest data.
                - **Flag Icons:** Our user interface includes country flag icons sourced from the Flags API to help you easily identify currencies.
                """)
                .font(.title2)
                .padding()
                .foregroundColor(.yellow)

               
                //Done Button
                Button("Done"){
                    dismiss()
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
     
        }
    }
}

#Preview {
    ExchangeInfo()
}

