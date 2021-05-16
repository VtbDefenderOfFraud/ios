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
        case documents
        case contactDetails
        
        case condition
        case politics
        case settings
        case logout
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(ProfileLogoutCell.self, forCellReuseIdentifier: "ProfileLogoutCell")
        tableView.register(CreditCell.self, forCellReuseIdentifier: "CreditCell")

        return tableView
    }()
    
    var sections: [[CellType]] = []
    
    var user: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.showActivity()
        
        Request.shared.userInfo { [weak self] response in
            guard let self = self,
                  let data = response.data,
                  let user: UserInfo = try? JSONDecoder().decode(UserInfo.self, from: data) else { return }
            
            self.user = user
            self.sections = [[.user], [.documents, .contactDetails], [.condition, .politics], [.settings], [.logout]]
            
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
}

extension ProfileController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.sections[indexPath.section][indexPath.row]
        switch type {
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(name: self.user?.name)
            
            return cell

        case .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLogoutCell", for: indexPath) as? ProfileLogoutCell else { return ProfileLogoutCell() }
            
            return cell
        case .documents:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(icon: #imageLiteral(resourceName: "1"), title: "Документы")
            
            return cell
            
        case .contactDetails:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(icon: #imageLiteral(resourceName: "2"), title: "Контактные данные")
            
            return cell
            
        case .condition:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(icon: #imageLiteral(resourceName: "3"), title: "Условия обслуживания")
            
            return cell
            
        case .politics:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(icon: #imageLiteral(resourceName: "3"), title: "Политика конфиденциальности")
            
            return cell
            
        case .settings:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return ProfileCell() }
            
            cell.set(icon: #imageLiteral(resourceName: "4"), title: "Настройки")
            
            return cell
        }
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = self.sections[indexPath.section][indexPath.row]
        switch type {
        case .user:
            return 80
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch CellType.allCases[indexPath.row] {
        case .logout:
            self.tableView.showActivity()
            Request.shared.logout { [weak self] in
                self?.tableView.hideActivity()
            }
        default: return
        }
    }
}

enum CreditIndex {
    static func color(index: Int) -> UIColor {
        switch index {
        case let x where x <= 629:
            return UIColor(red: 234/255, green: 79/255, blue: 78/255, alpha: 1)
        case let x where x > 629 && x <= 689:
            return UIColor(red: 245/255, green: 191/255, blue: 78/255, alpha: 1)
        case let x where x > 689 && x <= 719:
            return UIColor(red: 96/255, green: 174/255, blue: 139/255, alpha: 1)
        case let x where x > 719:
            return UIColor(red: 56/255, green: 127/255, blue: 89/255, alpha: 1)
        default:
            return UIColor(red: 56/255, green: 127/255, blue: 89/255, alpha: 1)
        }
    }
}





