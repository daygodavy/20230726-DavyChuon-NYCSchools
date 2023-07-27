//
//  SchoolListCell.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class SchoolListCell: UITableViewCell {

    // MARK: - Variables
    static let reuseID = "SchoolListCell"
    
    // MARK: - UI Components
    let schoolNameLabel = SchoolTitleLabel(textAlignment: .left, fontSize: 22, textColor: .systemBlue)
    let schoolGradesLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 16)
    let schoolLocationLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 16)
    let schoolTotalLabel = SchoolBodyLabel(textAlignment: .left, fontSize: 14)
    let schoolGraduationLabel = SchoolBodyLabel(textAlignment: .right, fontSize: 14)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - UI Setup
    private func configureCell() {
        backgroundColor = .systemBackground
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
    public func set(_ school: School) {
        schoolNameLabel.text = school.schoolName
        schoolLocationLabel.text = "\(school.city), \(school.stateCode)"
        schoolGradesLabel.text = "Grades: \(school.finalgrades)"
        schoolTotalLabel.text = "Students: \(school.totalStudents)"
        schoolGraduationLabel.text = "Graduation Rate: \(school.graduationRate)"
    }
}
