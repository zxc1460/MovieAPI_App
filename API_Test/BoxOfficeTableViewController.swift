//
//  BoxOfficeTableViewController.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import UIKit
import Alamofire

class BoxOfficeTableViewController: UITableViewController {
    var data: [DailyInfo] = [DailyInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.showIndicator()
        DataManager.shared.requestBoxOfficeData(day: Date.yesterday, viewController: self)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell") as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.rankLabel.text = data[indexPath.row].rank
        cell.titleLabel.text = data[indexPath.row].movieNm
        cell.releaseDateLabel.text = data[indexPath.row].openDt
        cell.audiCountLabel.text = data[indexPath.row].audiCnt + " 명"
        
        return cell
    }
    
}

extension BoxOfficeTableViewController {
    func didRetrieveBoxOfficeData(data: [DailyInfo]) {
        self.data = data
        self.dismissIndicator()
        self.tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
