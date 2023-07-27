//
//  String+Ext.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

extension String {
    
    // Shortens percent string to tenths position
    func formatToPercent() -> String {
        if let floatVal = Float(self) {
            let percentageValue = floatVal * 100
            let formattedString = String(format: "%.1f%%", percentageValue)
            return formattedString
        }
        return "N/A"
    }
    
    // Remove unnecessary suffix from string
    func removeExtraSuffix(_ suffixToRemove: String) -> String {
        guard self.hasSuffix(suffixToRemove) else { return self }
        
        return self.replacingOccurrences(of: suffixToRemove, with: "")
    }
}
