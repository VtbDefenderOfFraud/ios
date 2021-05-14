//
//  HistoryCell.swift
//  vtb
//
//  Created by Alina Golubeva on 12.05.2021.
//

import UIKit

final class HistoryCell: UITableViewCell {
    
    private var icon: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private var nameLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private var sumLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
    }
}
