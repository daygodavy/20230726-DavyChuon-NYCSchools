//
//  SchoolDetailsVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class SchoolDetailsVC: UIViewController {
    
    // MARK: - Variables
    var schoolViewModel: SchoolDetailsVM
    
    // MARK: - UI Components
    let schoolTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 24, textColor: .systemBlue)
    let schoolAddress = SchoolBodyLabel(textAlignment: .center, fontSize: 16)
    let schoolStatsView = SchoolStatsCardView()
    var mapView: SchoolMapView

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadingStats()
        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: SchoolDetailsVM) {
        schoolViewModel = viewModel
        mapView = SchoolMapView(schoolViewModel.coordinate)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Setup UI
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(schoolTitle)
        view.addSubview(mapView)
        view.addSubview(schoolAddress)
        view.addSubview(schoolStatsView)
        
        layoutUI()
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            schoolTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            schoolTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            schoolTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            mapView.topAnchor.constraint(equalTo: schoolTitle.bottomAnchor, constant: 30),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 250),
            
            schoolAddress.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5),
            schoolAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolAddress.heightAnchor.constraint(equalToConstant: 30),
            
            schoolStatsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolStatsView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            schoolStatsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            schoolStatsView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setLabels() {
        schoolTitle.text = schoolViewModel.schoolName
        schoolAddress.text = schoolViewModel.address
        schoolStatsView.set(viewModel: schoolViewModel)
    }
    
    private func loadingStats() {
        schoolViewModel.onStatsLoaded = { [weak self] school in
            guard let self = self, let school = school else { return }
            DispatchQueue.main.async {
                self.schoolViewModel.schoolStats = school
                self.setLabels()
            }
        }
    }
    
}
