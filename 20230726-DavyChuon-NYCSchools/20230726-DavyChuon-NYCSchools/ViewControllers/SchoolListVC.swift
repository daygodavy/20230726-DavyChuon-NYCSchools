//
//  SchoolListVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

class SchoolListVC: DataLoadingVC {

    // MARK: - Variables
    var schools: [School] = []
    var page: Int = 1
    var hasMoreSchools: Bool = true
    var fetchInProgress: Bool = false
    
    // MARK: - UI Components
    let tableView = UITableView()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        configureTableView()
        getSchools()
    }
    
    // MARK: - UI Setup
    private func configureTableView() {
        view.addSubview(tableView)
        layoutTableView()
        tableView.rowHeight = 250
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchoolListCell.self, forCellReuseIdentifier: SchoolListCell.reuseID)
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Methods
    private func getSchools() {
        // TODO: start showing spinner
        fetchInProgress = true
        showSpinner()
        Task {
            do {
                let schools = try await NetworkManager.shared.fetchSchools(page: page)
                updateUI(with: schools)
            } catch {
                // TODO: PRESENT CUSTOM ERROR WITH THE ERRORMANAGER RESPONSE
            }
            
            fetchInProgress = false
            hideSpinner()
        }
    }
    
    private func updateUI(with newSchools: [School]) {
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
    
    // Define spacing between cells
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // Determine when to continue paginating
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            guard !fetchInProgress, hasMoreSchools else { return }
            page += 1
            getSchools()
        }
    }
}
