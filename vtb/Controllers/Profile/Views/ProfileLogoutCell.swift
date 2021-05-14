//
//  ProfileLogoutCell.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class ProfileLogoutCell: UITableViewCell {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.addSubview(self.button)
        
        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
