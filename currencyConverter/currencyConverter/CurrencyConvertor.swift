//
//  CurrencyConvertor.swift
//  currencyConverter
//
//  Created by Andres Jimenez on 8/1/24.
//

import Foundation

struct CurrencyConverter {
    static func convert(_ amount: Double, from sourceCurrency: String, to targetCurrency: String) async throws -> Double {
        let rates = try await ExchangeRateService.shared.fetchExchangeRates(for: sourceCurrency)
        guard let rate = rates.conversionRates[targetCurrency] else {
            throw NSError(domain: "CurrencyConverter", code: 1, userInfo: [NSLocalizedDescriptionKey: "Conversion rate not found"])
        }
        return amount * rate
    }
}
