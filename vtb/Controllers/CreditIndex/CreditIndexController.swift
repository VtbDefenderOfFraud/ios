//
//  CreditIndexController.swift
//  vtb
//
//  Created by Alina Golubeva on 12.05.2021.
//

import UIKit
import LMGaugeViewSwift

final class CreditIndexController: ViewController {
    enum CellType: CaseIterable {
        case credit
        case chance
        case gauge
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
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
    
    var sections: [CellType] = []
    
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
            self.sections = [.credit, .chance, .gauge]
            
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
}

extension CreditIndexController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.sections[indexPath.row]
        switch type {
        case .credit:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell", for: indexPath) as? CreditCell else { return CreditCell() }
            
            cell.set(title: "Кредитный индекс", value: "\(self.user?.creditIndex ?? 0)", color: CreditIndex.color(index: (self.user?.creditIndex ?? 0)))
            
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
        }
    }
}

extension CreditIndexController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = self.sections[indexPath.row]
        switch type {
        case .credit, .chance:
            return UITableView.automaticDimension
        case .gauge:
            return 400
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
