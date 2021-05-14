//
//  HistoryController.swift
//  vtb
//
//  Created by Alina Golubeva on 21.04.2021.
//

import UIKit

final class HistoryController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.title = "История"
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.tableView.showActivity()
        Request.shared.history(skip: 0, take: 10) { [weak self] _ in
            
            self?.tableView.hideActivity()
        }
    }

}

extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return HistoryCell() }
        
        return cell
    }
}

extension HistoryController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}



extension UIView {
    static let activityTag = 1005
    
    func showActivity() {
        let container = UIView()
        container.backgroundColor = .white
        container.tag = Self.activityTag
        
        self.addSubview(container)
        container.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        
        let activityView = UIActivityIndicatorView(style: .gray)
        container.addSubview(activityView)
        activityView.startAnimating()
        
        activityView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func hideActivity() {
        self.viewInSubviews(tag: Self.activityTag)?.removeFromSuperview()
    }
    
    func viewInSubviews(tag: Int) -> UIView? {
        for view in self.subviews where view.tag == tag {
            return view
        }
        
        return nil
    }
}


