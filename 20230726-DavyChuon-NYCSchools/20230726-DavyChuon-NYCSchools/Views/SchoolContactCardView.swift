//
//  SchoolContactCardView.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/27/23.
//

import UIKit

class SchoolContactCardView: UIView {

    let contactImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "phone")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    } ()
    
    let contactSubTitle = SchoolTitleLabel(textAlignment: .center, fontSize: 18, textColor: .label)
    let phoneBodyLabel = SchoolBodyLabel(textAlignment: .center, fontSize: 14)
    let websiteBodyLabel = SchoolBodyLabel(textAlignment: .center, fontSize: 14)

    
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
            contactSubTitle.widthAnchor.constraint(equalToConstant: 100),
            
            contactImage.centerYAnchor.constraint(equalTo: contactSubTitle.centerYAnchor),
            contactImage.trailingAnchor.constraint(equalTo: contactSubTitle.leadingAnchor),
            contactImage.widthAnchor.constraint(equalToConstant: 25),
            contactImage.heightAnchor.constraint(equalToConstant: 25),
            
            phoneBodyLabel.topAnchor.constraint(equalTo: contactSubTitle.bottomAnchor, constant: 20),
            phoneBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneBodyLabel.heightAnchor.constraint(equalToConstant: 60),
            
            websiteBodyLabel.topAnchor.constraint(equalTo: phoneBodyLabel.bottomAnchor, constant: 30),
            websiteBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            websiteBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            websiteBodyLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func set(viewModel: SchoolDetailsVM) {
        contactSubTitle.text = "Contact"
        phoneBodyLabel.text = viewModel.phoneNumber
        websiteBodyLabel.text = viewModel.website
    }

}
