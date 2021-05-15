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
        gaugeView.delegate = self
        
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
        gaugeView.limitValue = 690
        
        gaugeView.value = Double(value)
    }
}

extension GaugeCell: GaugeViewDelegate {
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor {
        return CreditIndex.color(index: Int(value))
    }
}
