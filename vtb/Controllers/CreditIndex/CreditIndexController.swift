//
//  CreditIndexController.swift
//  vtb
//
//  Created by Alina Golubeva on 12.05.2021.
//

import UIKit
import LMGaugeViewSwift

final class CreditIndexController: ViewController {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.addArrangedSubview(self.titleStackView)
        stackView.addArrangedSubview(self.titleStackView1)
        stackView.addArrangedSubview(self.gaugeView)
        
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.valueLabel)
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var titleStackView1: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel1)
        stackView.addArrangedSubview(self.valueLabel1)
        
        return stackView
    }()
    
    private let titleLabel1: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let valueLabel1: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var gaugeView: GaugeView = {
        let gaugeView = GaugeView()
        
        gaugeView.backgroundColor = .white
        gaugeView.unitOfMeasurement = ""
        
        return gaugeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.title = "Кредитный индекс"
        
        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalTo(16)
            $0.right.bottom.equalTo(-16)
        }
        
        self.titleLabel.text = "Кредитный индекс"
        self.valueLabel.text = "700"
        self.titleLabel1.text = "Вероятность одобрения\nнового кредита"
        self.valueLabel1.text = "74%"
        
        gaugeView.minValue = 0
        gaugeView.maxValue = 1200
        gaugeView.limitValue = 1200
        
        
        
        
//        self.tableView.showActivity()
//        DataProvider.shared.history { [weak self] in
//
//            self?.tableView.hideActivity()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.gaugeView.value = 700

    }
    
}

extension CreditIndexController: GaugeViewDelegate {
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor {
        if value >= gaugeView.limitValue {
            return UIColor(red: 1, green: 59.0/255, blue: 48.0/255, alpha: 1)
        }

        return UIColor(red: 11.0/255, green: 150.0/255, blue: 246.0/255, alpha: 1)
    }
}

//extension UIView {
//
//    var safeArea: ConstraintBasicAttributesDSL {
//
//        #if swift(>=3.2)
//            if #available(iOS 11.0, *) {
//                return self.safeAreaLayoutGuide.snp
//            }
//            return self.snp
//        #else
//            return self.snp
//        #endif
//    }
//}
