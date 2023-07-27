//
//  SchoolDetailsVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class SchoolDetailsVC: UIViewController {
    
    // MARK: - Variables
    let schoolViewModel: SchoolDetailsVM
    
    // MARK: - UI Components
    let schoolTitleLabel = SchoolTitleLabel(textAlignment: .center, fontSize: 22, textColor: .systemBlue)
    let schoolReadingAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 18)
    let schoolWritingAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 18)
    let schoolMathAvg = SchoolBodyLabel(textAlignment: .left, fontSize: 18)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: SchoolDetailsVM) {
        schoolViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Setup UI
    private func configureUI() {
        view.addSubview(schoolTitleLabel)
        view.addSubview(schoolReadingAvg)
        view.addSubview(schoolWritingAvg)
        view.addSubview(schoolMathAvg)
        
        layoutUI()
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            schoolTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            schoolTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            schoolReadingAvg.topAnchor.constraint(equalTo: schoolTitleLabel.bottomAnchor),
            schoolReadingAvg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolReadingAvg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolReadingAvg.heightAnchor.constraint(equalToConstant: 30),
            
            schoolWritingAvg.topAnchor.constraint(equalTo: schoolReadingAvg.bottomAnchor),
            schoolWritingAvg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolWritingAvg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolWritingAvg.heightAnchor.constraint(equalToConstant: 30),
            
            schoolMathAvg.topAnchor.constraint(equalTo: schoolWritingAvg.bottomAnchor),
            schoolMathAvg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolMathAvg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolMathAvg.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setLabels() {
        schoolTitleLabel.text = schoolViewModel.schoolName
        schoolReadingAvg.text = schoolViewModel.readingAvgSAT
        schoolWritingAvg.text = schoolViewModel.writingAvgSAT
        schoolMathAvg.text = schoolViewModel.mathAvgSAT
    }
    
}
