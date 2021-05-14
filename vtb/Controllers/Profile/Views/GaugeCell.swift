//
//  GaugeCell.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import LMGaugeViewSwift

final class GaugeCell: UITableViewCell {
    
    private lazy var gaugeView: GaugeView = {
        let gaugeView = GaugeView()
        
        gaugeView.backgroundColor = .white
        gaugeView.unitOfMeasurement = ""
        gaugeView.valueFont = UIFont.boldSystemFont(ofSize: 50)
        
        return gaugeView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.addSubview(self.gaugeView)
        self.gaugeView.snp.makeConstraints {
            $0.left.top.equalTo(16)
            $0.right.bottom.equalTo(-16)
        }
    }
    
    func setup(min: Int, max: Int, value: Int) {
        gaugeView.minValue = Double(min)
        gaugeView.maxValue = Double(max)
        gaugeView.limitValue = Double(max)
        
        gaugeView.value = Double(value)
    }
}

extension GaugeCell: GaugeViewDelegate {
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor {
        if value >= gaugeView.limitValue {
            return UIColor(red: 1, green: 59.0/255, blue: 48.0/255, alpha: 1)
        }

        return UIColor(red: 11.0/255, green: 150.0/255, blue: 246.0/255, alpha: 1)
    }
}
