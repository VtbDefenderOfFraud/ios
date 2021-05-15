//
//  InsuredEventCell.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class InsuredEventCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleIconStackView)
        
        stackView.spacing = 16
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 24
        imageView.image = #imageLiteral(resourceName: "user")
        
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.priceLabel)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var titleIconStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.icon)
        stackView.addArrangedSubview(self.titleStackView)
        
        stackView.spacing = 8
        
        return stackView
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
        
        icon.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }
    
    func set(name: String?) {
        titleLabel.text = name
    }
}
