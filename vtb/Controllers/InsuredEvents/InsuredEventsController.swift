//
//  InsuredEventsControllerViewController.swift
//  vtb
//
//  Created by Alina Golubeva on 15.05.2021.
//

import UIKit

final class InsuredEventsController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(InsuredEventCell.self, forCellReuseIdentifier: "InsuredEventCell")

        return tableView
    }()
    
    var events: [InsuredEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.events = AppData.insures.map({ ins in
            InsuredEvent(name: ins.name,
                         sum: ins.sum,
                         currentStage: InsuredEvent.Stage(status: .current, name: "Первый", date: "01.12.2020"),
                                        stages: [InsuredEvent.Stage(status: .previous, name: "Первый", date: "01.12.2020"),
                                                 InsuredEvent.Stage(status: .previous, name: "Второй", date: "03.06.2021"),
                                                 InsuredEvent.Stage(status: .current, name: "Третий", date: "18.06.2021"),
                                                 InsuredEvent.Stage(status: .future, name: "Четвертый", date: "01.07.2021"),
                                                 InsuredEvent.Stage(status: .future, name: "Пятый", date: "10.07.2021")], icon: "https://clck.ru/UqLU3")
        })
        
        self.events.append(InsuredEvent(name: "Тинькофф",
                                        sum: "200000 ₽",
                                        currentStage: InsuredEvent.Stage(status: .current, name: "Третий", date: "18.06.2021"),
                                        stages: [InsuredEvent.Stage(status: .previous, name: "Первый", date: "01.12.2020"),
                                                 InsuredEvent.Stage(status: .previous, name: "Второй", date: "03.06.2021"),
                                                 InsuredEvent.Stage(status: .current, name: "Третий", date: "18.06.2021"),
                                                 InsuredEvent.Stage(status: .future, name: "Четвертый", date: "01.07.2021"),
                                                 InsuredEvent.Stage(status: .future, name: "Пятый", date: "10.07.2021")],
                                        icon: "https://clck.ru/UqLU3"))
    }
}


extension InsuredEventsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InsuredEventCell", for: indexPath) as? InsuredEventCell else { return InsuredEventCell() }
        
        cell.set(event: events[indexPath.row])
        
        return cell
    }
}

extension InsuredEventsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(UINavigationController(rootViewController: StagesController(insuredEvent: events[indexPath.row])),
                     animated: true, completion: nil)
    }
}
