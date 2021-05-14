//
//  RequestCell.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class RequestCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.numberStackView)
        stackView.addArrangedSubview(self.iinStackView)
        stackView.addArrangedSubview(self.dateStackView)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private var numberTitleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        
        return label
    }()
    
    private var numberValueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var numberStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.numberTitleLabel)
        stackView.addArrangedSubview(self.numberValueLabel)
        
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var iinTitleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        
        return label
    }()
    
    private var iinValueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var iinStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.iinTitleLabel)
        stackView.addArrangedSubview(self.iinValueLabel)
        
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var dateTitleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        
        return label
    }()
    
    private var dateValueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.dateTitleLabel)
        stackView.addArrangedSubview(self.dateValueLabel)
        
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
        addSubview(container)
        container.addSubview(stackView)
        
        container.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(8)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-8)
        }
        
        stackView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(8)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-8)
        }
    }
    
    func setup(info: RequestInfo) {
        titleLabel.text = info.bankName
        
        numberTitleLabel.text = "Гос.рег.номер"
        numberValueLabel.text = info.registrationNumber
        
        iinTitleLabel.text = "ИНН"
        iinValueLabel.text = info.tin
        
        dateTitleLabel.text = "Дата запроса"
        dateValueLabel.text = info.orderDate
    }
}
