//
//  SchoolListCell.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

// Custom UITableViewCell for SchoolListVC
class SchoolListCell: UITableViewCell {

    // MARK: - Variables
    static let reuseID = "SchoolListCell"
    
    // MARK: - UI Components
    let schoolNameLabel = SchoolTitleLabel(textAlignment: .left, fontSize: 20, textColor: .systemBlue)
    let schoolGradesLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 16)
    let schoolLocationLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 16)
    let schoolTotalLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 14)
    let schoolGraduationLabel = SchoolBodyLabel(textAlignment: .right, fontSize: 14)
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Edge case: handles dark / light mode toggle while cells dequeue
    override func prepareForReuse() {
        super.prepareForReuse()
        updateBorderColor()
    }
    
    
    // MARK: - UI Setup
    private func configureCell() {
        backgroundColor = .systemBackground
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 10.0
        selectedBackgroundView?.layer.cornerRadius = 10.0
    }
    
    
    private func configureViews() {
        addSubview(schoolNameLabel)
        addSubview(schoolGradesLabel)
        addSubview(schoolLocationLabel)
        addSubview(schoolTotalLabel)
        addSubview(schoolGraduationLabel)
        
        configureLayout()
    }
    
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            schoolNameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            schoolNameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            schoolLocationLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor),
            schoolLocationLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            schoolLocationLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            schoolLocationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            schoolGradesLabel.topAnchor.constraint(equalTo: schoolLocationLabel.bottomAnchor),
            schoolGradesLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            schoolGradesLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            schoolGradesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            schoolTotalLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            schoolTotalLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            schoolTotalLabel.widthAnchor.constraint(equalToConstant: 150),
            schoolTotalLabel.heightAnchor.constraint(equalToConstant: 30),
            
            schoolGraduationLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            schoolGraduationLabel.centerYAnchor.constraint(equalTo: schoolTotalLabel.centerYAnchor),
            schoolGraduationLabel.widthAnchor.constraint(equalToConstant: 200),
            schoolTotalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    // MARK: - Methods
    
    // Setter function for SchoolListVC TableView cells
    public func set(_ school: School) {
        schoolNameLabel.text = school.schoolName.removeExtraSuffix(", The")
        schoolLocationLabel.text = "\(school.city), \(school.stateCode)"
        schoolGradesLabel.text = "Grades: \(school.finalgrades)"
        schoolTotalLabel.text = "Students: \(school.totalStudents)"
        
        // Formats graduation rate string to tenths position
        schoolGraduationLabel.text = "Graduation Rate: N/A"
        guard let gradRate = school.graduationRate?.formatToPercent() else { return }
        schoolGraduationLabel.text = "Graduation Rate: \(gradRate)"
    }
    
    
    // Updates cell border color based on dark / light mode
    private func updateBorderColor() {
        if traitCollection.userInterfaceStyle == .dark {
            layer.borderColor = UIColor.systemGray3.cgColor
        } else {
            layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
}


// MARK: - SchoolListCell Extension
extension SchoolListCell {
    
    // Recognizes dark / light mode toggle
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateBorderColor()
    }
}
