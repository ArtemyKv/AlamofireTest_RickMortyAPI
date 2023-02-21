//
//  ListCell.swift
//  AlamofireTest
//
//  Created by Artem Kvashnin on 20.02.2023.
//

import UIKit

class ListCell: UITableViewCell {
    static let reuseIdentifier = "ListCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        return view
        
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        photoView.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(backView)
        contentView.addSubview(photoView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // backView constraints
            backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            backView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8),
            backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            // photo view constraints
            photoView.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.3),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            photoView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            photoView.topAnchor.constraint(equalTo: backView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            //stack constrainsts
            stackView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor)
        ])
    }
}
