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
        case credit
        case chance
        case gauge
        case logout
        
        
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(ProfileLogoutCell.self, forCellReuseIdentifier: "ProfileLogoutCell")
        tableView.register(CreditCell.self, forCellReuseIdentifier: "CreditCell")
        tableView.register(GaugeCell.self, forCellReuseIdentifier: "GaugeCell")

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
            self.sections = [[.user], [.credit, .chance, .gauge], [.logout]]
            
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
}

struct UserInfo: Codable {
    let id: Int
    let passport, name: String
    let creditIndex, ratingMin, ratingMax: Int
    let creditApprovalChance: Double
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
        case .credit:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell", for: indexPath) as? CreditCell else { return CreditCell() }
            
            cell.set(title: "Кредитный индекс", value: "\(self.user?.creditIndex ?? 0)")
            
            return cell
        case .chance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell", for: indexPath) as? CreditCell else { return CreditCell() }
            
            cell.set(title: "Вероятность одобрения нового кредита", value: "\(self.user?.creditApprovalChance ?? 0)%")
            
            return cell
        case .gauge:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GaugeCell", for: indexPath) as? GaugeCell else { return GaugeCell() }
            
            if let ratingMin = self.user?.ratingMin,
               let ratingMax = self.user?.ratingMax,
               let creditIndex = self.user?.creditIndex {
                cell.setup(min: ratingMin, max: ratingMax, value: creditIndex)
            }
            
            return cell
        case .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLogoutCell", for: indexPath) as? ProfileLogoutCell else { return ProfileLogoutCell() }
            
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
        case .credit, .chance:
            return UITableView.automaticDimension
        case .logout:
            return 44
        case .gauge:
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        switch CellType.allCases[indexPath.row] {
//        case .user: return
//        case .logout:
//            self.tableView.showActivity()
//            Request.shared.logout { [weak self] in
//                self?.tableView.hideActivity()
//            }
//        }
    }
    
    
}






