//
//  SchoolDetailsVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

// Detail view controller that displays information on selected school
class SchoolDetailsVC: DataLoadingVC {
    
    // MARK: - Variables
    var schoolViewModel: SchoolDetailsVM
    
    // MARK: - UI Components
    let schoolTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 28, textColor: .systemBlue)
    let schoolAddress = SchoolBodyLabel(textAlignment: .center, fontSize: 16)
    let schoolStatsView = SchoolStatsCardView()
    let schoolContactView = SchoolContactCardView()
    var mapView: SchoolMapView
    
    let headerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.systemGray5.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
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
    
    // Initializes view controller with view model of selected school
    init(_ viewModel: SchoolDetailsVM) {
        schoolViewModel = viewModel
        mapView = SchoolMapView(schoolViewModel.coordinate)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - Setup UI
    private func configureView() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        view.backgroundColor = .systemBackground
        updateShadow()
    }
    
    
    private func configureSubviews() {
        view.addSubview(headerBackgroundView)
        view.addSubview(schoolTitle)
        view.addSubview(mapView)
        view.addSubview(schoolAddress)
        view.addSubview(schoolStatsView)
        view.addSubview(schoolContactView)
        
        layoutUI()
    }
    
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            schoolStatsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            schoolStatsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2),
            schoolStatsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            schoolStatsView.heightAnchor.constraint(equalToConstant: 250),
            
            schoolContactView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2),
            schoolContactView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            schoolContactView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            schoolContactView.heightAnchor.constraint(equalToConstant: 250),
            
            headerBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerBackgroundView.bottomAnchor.constraint(equalTo: schoolAddress.bottomAnchor, constant: 10),
            
            schoolTitle.topAnchor.constraint(equalTo: headerBackgroundView.topAnchor, constant: 10),
            schoolTitle.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor, constant: 5),
            schoolTitle.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor, constant: -5),
            
            mapView.topAnchor.constraint(equalTo: schoolTitle.bottomAnchor, constant: 30),
            mapView.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.6),
            
            schoolAddress.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5),
            schoolAddress.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor),
            schoolAddress.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor),
            schoolAddress.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    
    // MARK: - Methods
    
    // Sets text labels based on view model data
    private func setLabels() {
        schoolTitle.text = schoolViewModel.schoolName
        schoolAddress.text = schoolViewModel.address
        schoolStatsView.set(viewModel: schoolViewModel)
        schoolContactView.set(viewModel: schoolViewModel)
    }
    
    
    // Handler to ensure SAT stats data was fetched and UI updated
    private func loadingStats() {
        schoolViewModel.onStatsLoaded = { [weak self] school in
            guard let self = self, let school = school else { return }
            
            DispatchQueue.main.async {
                self.showSpinner()
                self.schoolViewModel.schoolStats = school
                self.setLabels()
                self.hideSpinner()
            }
        }
    }
}


// MARK: - SchoolDetailsVC Extension
extension SchoolDetailsVC {
    
    // Recognizes dark / light mode toggle and updates accordingly
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

       if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {

           updateShadow()
       }
    }
    
    
    // Updates background shadow based on dark / light mode
    private func updateShadow() {
        headerBackgroundView.layer.shadowColor =
               UIColor.label.resolvedColor(with: self.traitCollection).cgColor
    }
}
