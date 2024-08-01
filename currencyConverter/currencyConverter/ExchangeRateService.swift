//
//  ExchangeRateService.swift
//  currencyConverter
//
//  8/1/24.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let baseCode: String
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case result
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}


class ExchangeRateService {
    static let shared = ExchangeRateService()
    private init() {}
    
    func fetchExchangeRates(for baseCurrency: String) async throws -> ExchangeRateResponse {
        let apiKey = "707cc1b756d490bc6eaa7e6d" 
        let urlString = "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(baseCurrency)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Print the raw JSON data for debugging
        if let jsonString = String(data: data, encoding: .utf8) {
            print("JSON Response: \(jsonString)")
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(ExchangeRateResponse.self, from: data)
    }
}
