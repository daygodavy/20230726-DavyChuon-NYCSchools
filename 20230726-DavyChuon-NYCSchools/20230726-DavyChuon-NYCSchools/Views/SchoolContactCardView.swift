//
//  SchoolContactCardView.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/27/23.
//

import UIKit

class SchoolContactCardView: UIView {

    // MARK: - UI Components
    let contactSubTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 18, textColor: .label)
    let phoneBodyLabel = SchoolBodyLabel(textAlignment: .center, fontSize: 14)
    let websiteBodyLabel = SchoolBodyLabel(textAlignment: .center, fontSize: 14)
    
    let contactImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "phone")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    } ()

    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureBackground()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func configureBackground() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.systemGray5.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        translatesAutoresizingMaskIntoConstraints = false
        
        updateShadow()
    }
    
    
    private func configureSubviews() {
        addSubview(contactImage)
        addSubview(contactSubTitle)
        addSubview(phoneBodyLabel)
        addSubview(websiteBodyLabel)
        
        layoutUI()
    }
    
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            contactSubTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contactSubTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            contactSubTitle.heightAnchor.constraint(equalToConstant: 30),
            contactSubTitle.widthAnchor.constraint(equalToConstant: 80),
            
            contactImage.centerYAnchor.constraint(equalTo: contactSubTitle.centerYAnchor),
            contactImage.trailingAnchor.constraint(equalTo: contactSubTitle.leadingAnchor),
            contactImage.widthAnchor.constraint(equalToConstant: 25),
            contactImage.heightAnchor.constraint(equalToConstant: 25),
            
            phoneBodyLabel.topAnchor.constraint(equalTo: contactSubTitle.bottomAnchor, constant: 36),
            phoneBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneBodyLabel.heightAnchor.constraint(equalToConstant: 50),
            
            websiteBodyLabel.topAnchor.constraint(equalTo: phoneBodyLabel.bottomAnchor, constant: 30),
            websiteBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            websiteBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            websiteBodyLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    
    // MARK: - Methods
    
    // Uses view model to set text labels
    func set(viewModel: SchoolDetailsVM) {
        contactSubTitle.text = "Contact"
        phoneBodyLabel.text = viewModel.phoneNumber
        websiteBodyLabel.text = viewModel.website
    }
}


// MARK: - SchoolContactCardView Extension
extension SchoolContactCardView {
    
    // Recognizes dark / light mode toggle and updates accordingly
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {

           updateShadow()
       }
    }
    
    
    // Updates background shadow based on dark / light mode
    private func updateShadow() {
        layer.shadowColor =
               UIColor.label.resolvedColor(with: self.traitCollection).cgColor
    }
}
