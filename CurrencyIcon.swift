//
//  CurrencyIcon.swift
//  currencyConverter
//
//  Created on 7/31/24.
//

import SwiftUI

struct CurrencyFlag: View {
    let countryCode: String
    let currencyName: String
    
    var body: some View {
        VStack(spacing: 5) {
            // Flag Image
            AsyncImage(url: URL(string: "https://flagcdn.com/w80/\(countryCode.lowercased()).png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                case .failure:
                    Image(systemName: "flag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 40)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            // Currency name
            Text(currencyName)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 40)
        }
        .frame(width: 80, height: 90)
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        CurrencyFlag(countryCode: "US", currencyName: "US Dollar")
    }
}
