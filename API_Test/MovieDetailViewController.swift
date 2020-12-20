//
//  MovieDetailViewController.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import UIKit
import Cosmos

class MovieDetailViewController: UIViewController {
    var movieName: String?
    var data: [Review] = [Review]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieName = movieName {
            data = CoreDataManager.shared.fecthByMovieName(movieName: movieName)
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    */

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = data[indexPath.row].name
        cell.contentLabel.text = data[indexPath.row].content
        DispatchQueue(label: "background").async {
            do {
                if let imageUrl = self.data[indexPath.row].imageUrl, let url = URL(string: imageUrl) {
                    let imageData = try Data(contentsOf: url)
                    if let img = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            cell.imageView?.image = img
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
    
    
}
