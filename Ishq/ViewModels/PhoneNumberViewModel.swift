//
//  PhoneNumberViewModel.swift
//  Ishq
//
//  Created by Sishir Mohan on 2/18/24.
//
import Foundation
import Combine

class PhoneNumberViewModel: ObservableObject {
    // Raw phone number input
    @Published var rawPhoneNumber: String = ""
    
    // Formatted phone number for display
    var formattedPhoneNumber: String {
        // Remove non-numeric characters
        let digits = rawPhoneNumber.filter { $0.isNumber }
        
        // Limit to 10 characters
        let trimmed = String(digits.prefix(10))
        
        // Format
        return self.formatPhoneNumber(trimmed)
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        guard !number.isEmpty else { return "" }
        
        // Split the number into parts
        let areaCode = String(number.prefix(3))
        let middle = String(number.dropFirst(3).prefix(3))
        let last = String(number.dropFirst(6))
        
        // Combine parts with formatting
        var formatted = "(" + areaCode + ")"
        if !middle.isEmpty {
            formatted += "-\(middle)"
        }
        if !last.isEmpty {
            formatted += "-\(last)"
        }
        
        return formatted
    }
    
    // Subscription to handle input changes and formatting
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $rawPhoneNumber
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
