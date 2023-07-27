//
//  String+Ext.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

extension String {
    
    // Calculates minimum height for UILabel based on its width and text size
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    // Concatenates a string represented as a percentage
    func formatToPercent() -> String {
        if let floatVal = Float(self) {
            let percentageValue = floatVal * 100
            let formattedString = String(format: "%.1f%%", percentageValue)
            return formattedString
        }
        return "N/A"
    }
}
