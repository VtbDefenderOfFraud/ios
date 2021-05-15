//
//  CreditCell.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class CreditCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.valueLabel)
        
        stackView.spacing = 8
//        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        
        label.contentHuggingPriority(for: .horizontal)
        
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
            $0.top.equalTo(8)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-8)
        }
    }
    
    func set(title: String, value: String, color: UIColor = .black) {
        titleLabel.text = title
        valueLabel.textColor = color
        valueLabel.text = value
    }
}
