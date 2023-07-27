//
//  DataLoadingVC.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/26/23.
//

import UIKit

// General view controller to notify user of network call in progress via spinner
class DataLoadingVC: UIViewController {

    // MARK: - UI Components
    var containerView: UIView!
    
    // MARK: - UI Setup
    
    // Container view that encapsulates the spinner and covers parent view
    private func setupContainerView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
    }
    
    
    // Activity indicator added on container view and animated
    private func setupSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        containerView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    
    // MARK: - Methods
    func showSpinner() {
        setupContainerView()
        setupSpinner()
    }
    
    
    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
