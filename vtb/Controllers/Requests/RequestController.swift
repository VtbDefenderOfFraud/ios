//
//  RequestController.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class RequestController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RequestCell.self, forCellReuseIdentifier: "RequestCell")

        return tableView
    }()
    
    var info: [RequestInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.showActivity()
        
        Request.shared.requests(skip: 0, take: 10) { [weak self] response in
            guard let self = self,
                  let data = response.data,
                  let info: [RequestInfo] = try? JSONDecoder().decode([RequestInfo].self, from: data) else { return }
            
            self.info = info
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
}


extension RequestController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as? RequestCell else { return RequestCell() }
        
        cell.setup(info: self.info[indexPath.row])
        
        return cell
    }
}

struct RequestInfo: Codable {
    let bankName, registrationNumber, tin, orderDate: String
}

extension RequestController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
