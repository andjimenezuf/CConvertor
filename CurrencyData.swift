//
//  CurrencyData.swift
//  currencyConverter
//  8/1/24.

struct CurrencyData {
    static let currencies: [(countryCode: String, currencyCode: String, name: String)] = [
        ("US", "USD", "US Dollar"),
        ("EU", "EUR", "Euro"),
        ("GB", "GBP", "British Pound"),
        ("JP", "JPY", "Japanese Yen"),
        ("CA", "CAD", "Canadian Dollar"),
        ("AU", "AUD", "Australian Dollar"),
        ("CH", "CHF", "Swiss Franc"),
        ("CN", "CNY", "Chinese Yuan"),
        ("IN", "INR", "Indian Rupee"),
  
        // Add more currencies here
    ]
    
    static func getCurrencyCode(for countryCode: String) -> String {
        currencies.first { $0.countryCode == countryCode }?.currencyCode ?? countryCode
    }
    
    static func getCountryCode(for currencyCode: String) -> String {
        currencies.first { $0.currencyCode == currencyCode }?.countryCode ?? currencyCode
    }
    
    static func getCurrencyName(for currencyCode: String) -> String {
        currencies.first { $0.currencyCode == currencyCode }?.name ?? currencyCode
    }
}


