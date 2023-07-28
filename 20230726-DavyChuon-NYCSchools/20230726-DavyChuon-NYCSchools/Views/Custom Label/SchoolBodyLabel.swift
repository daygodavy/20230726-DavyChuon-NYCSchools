//
//  SchoolBodyLabel.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

// Generic UILabel class used for 'body' text
class SchoolBodyLabel: UILabel {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    
    // MARK: - UI Setup
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.70
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}
