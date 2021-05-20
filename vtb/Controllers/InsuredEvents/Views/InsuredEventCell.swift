//
//  InsuredEventCell.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class InsuredEventCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.priceLabel)
        stackView.addArrangedSubview(self.statusLabel)
        
        stackView.spacing = 4
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.icon)
        stackView.addArrangedSubview(self.titleStackView)
        
        stackView.spacing = 8
        stackView.alignment = .top
        
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
            $0.top.equalTo(8)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-8)
        }
        
        icon.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }
        
    }
    
    func set(event: InsuredEvent) {
        titleLabel.text = event.name
        priceLabel.text = event.sum
        
        statusLabel.text = event.currentStage.name
        statusLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        
        icon.set(url: event.icon)
    }
}
