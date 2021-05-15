//
//  InsuredEventsControllerViewController.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class InsuredEventsController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")

        return tableView
    }()
    
    var credits: [Credits] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.showActivity()
        
        Request.shared.history(skip: 0, take: 10) { [weak self] response in
            guard let self = self,
                  let data = response.data,
                  let credits: [Credits] = try? JSONDecoder().decode([Credits].self, from: data) else { return }
            
            self.credits = credits
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
}


extension InsuredEventsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return HistoryCell() }
        
        cell.setup(credit: self.credits[indexPath.row])
        
        return cell
    }
}

extension InsuredEventsController: UITableViewDelegate {
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
