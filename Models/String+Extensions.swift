//
//  String+Extensions.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 11/28/25.
//

import Foundation

extension String {
    func cleanHTML() -> String {
        var text = self
        
        
        text = text.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        text = text.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
        
      
        text = text.replacingOccurrences(of: ". ", with: ".\n\n• ")
        
        var trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !trimmed.isEmpty && !trimmed.hasPrefix("•") {
            trimmed = "• " + trimmed
        }
        if trimmed.hasSuffix("•") {
            trimmed = String(trimmed.dropLast(1)).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return trimmed
    }
}
