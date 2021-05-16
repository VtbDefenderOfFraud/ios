//
//  ProfileCell.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class ProfileCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.photo)
        stackView.addArrangedSubview(self.titleLabel)
        
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 24
        imageView.image = #imageLiteral(resourceName: "user")
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(self.stackView)
        
        stackView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.centerY.equalToSuperview()
        }
        
        photo.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }
    
    func set(name: String?) {
        titleLabel.text = name
        
        photo.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }
    
    func set(icon: UIImage, title: String) {
        titleLabel.text = title
        photo.image = icon
        
        photo.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
}
