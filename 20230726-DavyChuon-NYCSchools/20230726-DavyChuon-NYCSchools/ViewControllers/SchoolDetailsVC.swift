//
//  SchoolDetailsVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class SchoolDetailsVC: DataLoadingVC {
    
    // MARK: - Variables
    var schoolViewModel: SchoolDetailsVM
    
    // MARK: - UI Components
    let schoolTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 28, textColor: .systemBlue)
    let schoolAddress = SchoolBodyLabel(textAlignment: .center, fontSize: 16)
    let schoolStatsView = SchoolStatsCardView()
    let schoolContactView = SchoolContactCardView()
    var mapView: SchoolMapView

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSubviews()
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
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func configureSubviews() {
        view.addSubview(schoolTitle)
        view.addSubview(mapView)
        view.addSubview(schoolAddress)
        view.addSubview(schoolStatsView)
        view.addSubview(schoolContactView)
        
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
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.5),
            
            schoolAddress.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5),
            schoolAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            schoolAddress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            schoolAddress.heightAnchor.constraint(equalToConstant: 30),
            
            schoolStatsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            schoolStatsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2),
            schoolStatsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            schoolStatsView.heightAnchor.constraint(equalToConstant: 250),
            
            schoolContactView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2),
            schoolContactView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            schoolContactView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            schoolContactView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setLabels() {
        schoolTitle.text = schoolViewModel.schoolName
        schoolAddress.text = schoolViewModel.address
        schoolStatsView.set(viewModel: schoolViewModel)
        schoolContactView.set(viewModel: schoolViewModel)
    }
    
    private func loadingStats() {
        print("1=====")
        schoolViewModel.onStatsLoaded = { [weak self] school in
            print("2=====")
            guard let self = self, let school = school else { return }
            print("3=====")
            DispatchQueue.main.async {
                self.showSpinner()
                print("4=====")
                self.schoolViewModel.schoolStats = school
                print("5=====")
                self.setLabels()
                print("6=====")
                self.hideSpinner()
            }
            print("7=====")
        }
        print("8=====")
    }
}
