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
        
        title = "Страховые случаи"

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.tableView.showActivity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.events.removeAll()
            
            if let data = UserDefaults.standard.object(forKey: "insure") as? Data,
               let savedArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Insure] {
                self.events = savedArray.map { insure in
                    InsuredEvent(name: insure.name,
                                 sum: insure.sum,
                                 currentStage: InsuredEvent.Stage(status: .current, name: "Отправка заявления в кредитную организацию", date: "01.12.2020"),
                                                stages: [InsuredEvent.Stage(status: .current, name: "Отправка заявления в кредитную организацию", date: "01.12.2020"),
                                                         InsuredEvent.Stage(status: .future, name: "Сбор документов", date: "03.06.2021"),
                                                         InsuredEvent.Stage(status: .future, name: "Направление заявления в полицию", date: "18.06.2021"),
                                                         InsuredEvent.Stage(status: .future, name: "Судебное заседание", date: "01.07.2021"),
                                                         InsuredEvent.Stage(status: .future, name: "Кредитная история восстановлена", date: "10.07.2021")], icon: insure.icon)
                }}
            
            self.events.append(InsuredEvent(name: "МФО \"Копеечка онлайн\"",
                                            sum: "200000 ₽",
                                            currentStage: InsuredEvent.Stage(status: .current, name: "Направление заявления в полицию", date: "18.06.2021"),
                                            stages: [InsuredEvent.Stage(status: .previous, name: "Отправка заявления в кредитную организацию", date: "01.12.2020"),
                                                     InsuredEvent.Stage(status: .previous, name: "Сбор документов", date: "03.06.2021"),
                                                     InsuredEvent.Stage(status: .current, name: "Направление заявления в полицию", date: "18.06.2021"),
                                                     InsuredEvent.Stage(status: .future, name: "Судебное заседание", date: "01.07.2021"),
                                                     InsuredEvent.Stage(status: .future, name: "Кредитная история восстановлена", date: "10.07.2021")],
                                            icon:"https://thumbs.dreamstime.com/b/%D0%B4%D0%BE%D0%BB%D0%BB%D0%B0%D1%80%D1%8B-%D0%B1%D1%83%D0%BC%D0%B0%D0%B6%D0%BD%D0%B8%D0%BA%D0%B0-106333183.jpg"))
            
            self.tableView.reloadData()
            self.tableView.hideActivity()
        }
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
