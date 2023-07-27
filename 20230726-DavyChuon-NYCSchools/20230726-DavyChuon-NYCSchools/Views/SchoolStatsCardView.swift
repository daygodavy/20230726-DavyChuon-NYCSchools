//
//  SchoolDetailsCardView.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/27/23.
//

import UIKit

class SchoolStatsCardView: UIView {

    let statsImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "building.columns.circle")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    } ()
    
    let statsSubTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 18, textColor: .label)
    let schoolReadingAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 14)
    let schoolWritingAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 14)
    let schoolMathAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureBackground()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackground() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 18
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSubviews() {
        addSubview(statsImage)
        addSubview(statsSubTitle)
        addSubview(schoolReadingAvg)
        addSubview(schoolWritingAvg)
        addSubview(schoolMathAvg)
        
        layoutUI()
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            statsSubTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            statsSubTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            statsSubTitle.heightAnchor.constraint(equalToConstant: 30),
            statsSubTitle.widthAnchor.constraint(equalToConstant: 100),
            
            statsImage.centerYAnchor.constraint(equalTo: statsSubTitle.centerYAnchor),
            statsImage.trailingAnchor.constraint(equalTo: statsSubTitle.leadingAnchor, constant: -5),
            statsImage.widthAnchor.constraint(equalToConstant: 25),
            statsImage.heightAnchor.constraint(equalToConstant: 25),
            
            schoolReadingAvg.topAnchor.constraint(equalTo: statsSubTitle.bottomAnchor, constant: 30),
            schoolReadingAvg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            schoolReadingAvg.trailingAnchor.constraint(equalTo: trailingAnchor),
            schoolReadingAvg.heightAnchor.constraint(equalToConstant: 30),
            
            schoolWritingAvg.topAnchor.constraint(equalTo: schoolReadingAvg.bottomAnchor),
            schoolWritingAvg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            schoolWritingAvg.trailingAnchor.constraint(equalTo: trailingAnchor),
            schoolWritingAvg.heightAnchor.constraint(equalToConstant: 30),
            
            schoolMathAvg.topAnchor.constraint(equalTo: schoolWritingAvg.bottomAnchor),
            schoolMathAvg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            schoolMathAvg.trailingAnchor.constraint(equalTo: trailingAnchor),
            schoolMathAvg.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func set(viewModel: SchoolDetailsVM) {
        statsSubTitle.text = "Academics"
        schoolReadingAvg.text = viewModel.readingAvgSAT
        schoolWritingAvg.text = viewModel.writingAvgSAT
        schoolMathAvg.text = viewModel.mathAvgSAT
    }
}
