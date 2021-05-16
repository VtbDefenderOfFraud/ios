//
//  StagesController.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class StagesController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(StageCell.self, forCellReuseIdentifier: "StageCell")

        return tableView
    }()
    
    var insuredEvent: InsuredEvent
    
    init(insuredEvent: InsuredEvent) {
        self.insuredEvent = insuredEvent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title = insuredEvent.name
    }
}


extension StagesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insuredEvent.stages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StageCell", for: indexPath) as? StageCell else { return StageCell() }

        let stage = insuredEvent.stages[indexPath.row]
        
        cell.set(stage: stage, current: insuredEvent.currentStage == stage)
        
        return cell
    }
}

extension StagesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
