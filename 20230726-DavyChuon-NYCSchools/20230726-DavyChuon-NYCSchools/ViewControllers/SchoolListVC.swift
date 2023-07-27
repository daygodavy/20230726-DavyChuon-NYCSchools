//
//  SchoolListVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

// Initial view controller that displays list of NYC schools
class SchoolListVC: DataLoadingVC {

    // MARK: - Variables
    var schools: [School] = []
    var page: Int = 1
    var hasMoreSchools: Bool = true
    var fetchInProgress: Bool = false
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 200
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SchoolListCell.self, forCellReuseIdentifier: SchoolListCell.reuseID)
        return tv
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        getSchools()
    }
    
    
    // MARK: - UI Setup
    private func configureView() {
        view.backgroundColor = .secondarySystemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Back"
        navigationItem.backBarButtonItem = backBarBtnItem
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        layoutTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
    // MARK: - Methods
    
    // Fetches NYC schools and appends to list to display in table view
    private func getSchools() {
        fetchInProgress = true
        showSpinner()
        Task {
            do {
                let schools = try await NetworkManager.shared.fetchAllSchools(page: page)
                updateUI(with: schools)
            } catch {
                if let error = error as? ErrorManager {
                    presentAlert(title: "Something went wrong!", message: error.rawValue)
                } else {
                    presentAlert()
                }
            }
            
            fetchInProgress = false
            hideSpinner()
        }
    }
    
    
    // Updates table view with NYC schools
    private func updateUI(with newSchools: [School]) {
        
        // Edge case: if fetched less than limit amount of schools,
        // then no more schools to fetch
        if newSchools.count < 25 { hasMoreSchools = false }
        self.schools.append(contentsOf: newSchools)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}


// MARK: - UITableView Protocols
extension SchoolListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schools.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolListCell.reuseID) as! SchoolListCell
        let school = schools[indexPath.section]
        cell.set(school)
        
        return cell
    }
    
    
    // Create blank footer to emulate spacing between cells
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    // Defines spacing between cells
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    // Determines when to continue paginating
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        // If user scrolls to end of list; fetch more schools
        if offsetY > contentHeight - frameHeight {
            guard !fetchInProgress, hasMoreSchools else { return }
            page += 1
            getSchools()
        }
    }
    
    
    // On cell selected: defines corresponding SchoolStats with view model
    // and instantiates SchoolDetailsVC to present
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let school = schools[indexPath.section]
        let schoolStats = SchoolStats(dbn: school.dbn,
                                      schoolName: school.schoolName,
                                      satCriticalReadingAvgScore: "N/A",
                                      satMathAvgScore: "N/A",
                                      satWritingAvgScore: "N/A")
        
        let vm = SchoolDetailsVM(schoolStats: schoolStats, school: school)
        let vc = SchoolDetailsVC(vm)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
