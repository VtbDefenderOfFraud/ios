//
//  ProfileController.swift
//  vtb
//
//  Created by Alina Golubeva on 23.04.2021.
//

import UIKit

final class ProfileController: ViewController {
    enum CellType: CaseIterable {
        case user
        case logout
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(ProfileLogoutCell.self, forCellReuseIdentifier: "ProfileLogoutCell")

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.showActivity()
        DataProvider.shared.history { [weak self] in
            
            self?.tableView.hideActivity()
            
            self?.tableView.reloadData()
        }
    }
}

extension ProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellType.allCases[indexPath.row] {
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            return cell
        case .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLogoutCell", for: indexPath) as? ProfileLogoutCell else { return ProfileLogoutCell() }
            
            return cell
        }
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch CellType.allCases[indexPath.row] {
        case .user:
            return 150
        case .logout:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch CellType.allCases[indexPath.row] {
        case .user: return
        case .logout:
            self.tableView.showActivity()
            DataProvider.shared.logout { [weak self] in
                self?.tableView.hideActivity()
            }
        }
    }
    
    
}

final class ProfileCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(self.photo)
        stackView.addArrangedSubview(self.titleLabel)
        
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 24
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = .zero
        label.text = "Фамилия Имя\nОтчество"
        
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
            $0.right.equalTo(-16)
            $0.centerY.equalToSuperview()
        }
        
        photo.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }
}

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
