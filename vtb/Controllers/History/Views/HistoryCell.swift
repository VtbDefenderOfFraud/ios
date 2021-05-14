//
//  HistoryCell.swift
//  vtb
//
//  Created by Alina Golubeva on 12.05.2021.
//

import UIKit

final class HistoryCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleIconStackView)
        stackView.addArrangedSubview(self.paymentStackView)
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
    
    
    private var paymentTitleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        
        return label
    }()
    
    private var paymentValueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var paymentStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.paymentTitleLabel)
        stackView.addArrangedSubview(self.paymentValueLabel)
        
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
        
        icon.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }
    }
    
    func setup(credit: Credits) {
        titleLabel.text = credit.bankName
        priceLabel.text = "\(credit.totalSum) ₽"
//        numberTitleLabel.text = "Гос.рег.номер"
//        numberValueLabel.text = info.registrationNumber
//
//        iinTitleLabel.text = "ИНН"
//        iinValueLabel.text = info.tin
        paymentTitleLabel.text = "Выплачено"
        paymentValueLabel.text = "\(credit.payment) ₽"
        
        dateTitleLabel.text = "Дата"
        dateValueLabel.text = credit.paymentDateTime
    }
}
