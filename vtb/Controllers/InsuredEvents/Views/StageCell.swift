//
//  StageCell.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class StageCell: UITableViewCell {
    
    private var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var pulseView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 25
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.autoreverses = true
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1
        alphaAnimation.toValue = 0
        alphaAnimation.autoreverses = true
        
        let animations = CAAnimationGroup()
        animations.duration = 0.8
        animations.repeatCount = Float.infinity
        animations.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animations.animations = [scaleAnimation, alphaAnimation]
        view.layer.add(animations, forKey: "animations")
        
        return view
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.valueLabel)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
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
        addSubview(lineView)
        addSubview(pulseView)
        addSubview(circleView)
        addSubview(stackView)
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(6)
            $0.left.equalTo(32)
            $0.top.bottom.equalToSuperview()
        }
        
        pulseView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.center.equalTo(self.lineView)
        }
        
        circleView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.center.equalTo(self.lineView)
        }
                
        stackView.snp.makeConstraints {
            $0.left.equalTo(lineView).offset(32)
            $0.top.equalTo(30)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-30)
        }
    }
    
    func set(stage: InsuredEvent.Stage, current: Bool) {
        titleLabel.text = stage.name
        valueLabel.text = stage.date
        
        self.pulseView.isHidden = !current
        
        lineView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.5)
        circleView.backgroundColor = stage.status.color
        pulseView.backgroundColor = stage.status.color
        
        titleLabel.textColor = stage.status.color
        valueLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }
}
