//
//  InsureController.swift
//  vtb
//
//  Created by Alina Golubeva on 16.05.2021.
//

import UIKit

struct Insure {
    let name: String
    let icon: String
    let sum: String
    let date: String
    let description: String
}

final class InsureController: ViewController {

    private var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        
        stackView.addArrangedSubview(self.icon)
        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.descriptionLabel)
        stackView.addArrangedSubview(self.buttonStackView)
        
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        stackView.addArrangedSubview(self.yesButton)
        stackView.addArrangedSubview(self.noButton)
        
        return stackView
    }()
    
    private var yesButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 12
        button.setTitle("Да", for: .normal)
        button.backgroundColor = UIColor(red: 96/255, green: 174/255, blue: 139/255, alpha: 1)
        button.addTarget(self, action: #selector(yesAction), for: .touchUpInside)
        
        return button
    }()
    
    private var noButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 12
        button.setTitle("Нет", for: .normal)
        button.backgroundColor = UIColor(red: 234/255, green: 79/255, blue: 78/255, alpha: 1)
        button.addTarget(self, action: #selector(noAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    func noAction() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "insure"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func yesAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let insure: Insure
    
    init(insure: Insure) {
        self.insure = insure
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var previous = AppData.insures
        previous.append(insure)
        
        AppData.insures = previous

        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(50)
            $0.right.equalTo(-16)
        }
        
        self.icon.snp.makeConstraints {
            $0.width.height.equalTo(200)
        }
        
        self.buttonStackView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
        }
        
        self.icon.set(url: insure.icon)
        self.titleLabel.text = insure.name
        self.descriptionLabel.text = insure.description
    }
}
