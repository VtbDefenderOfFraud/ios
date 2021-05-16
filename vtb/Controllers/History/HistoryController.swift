//
//  HistoryController.swift
//  vtb
//
//  Created by Alina Golubeva on 21.04.2021.
//

import UIKit

final class HistoryController: ViewController {

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
            print(response)
            guard let self = self,
                  let data = response.data,
                  let credits: [Credits] = try? JSONDecoder().decode([Credits].self, from: data) else { return }
            
            self.credits = credits
            self.tableView.hideActivity()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.present(InsureController(insure: Insure(name: "Тинькофф", icon: "https://clck.ru/UqLU3",
//                                                         description: "Задача организации, в особенности же консультация с широким активом представляет собой интересный эксперимент проверки дальнейших направлений развития. Идейные соображения высшего порядка, а также дальнейшее развитие различных форм деятельности способствует подготовки и реализации существенных финансовых и административных условий.")),
//                         animated: true, completion: nil)
//        }
        
    }
}


extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return HistoryCell() }
        
        cell.setup(credit: self.credits[indexPath.row])
        
        return cell
    }
}

struct Credits: Codable {
    let bankName: String
    let totalSum, payment: Int
    let paymentDateTime: String
    let bankIcoUrl: String
    let state: Int
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        guard let value = formatter.date(from: paymentDateTime) else { return paymentDateTime }
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: value)
    }
}

extension HistoryController: UITableViewDelegate {
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



