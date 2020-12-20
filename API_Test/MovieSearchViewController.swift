//
//  MovieSearchViewController.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import UIKit
import Alamofire

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let text = searchTextField.text, text != "" {
            self.showIndicator()
            DataManager.shared.requestMovieLists(title: text, viewController: self)
        } else {
            self.presentAlert(title: "영화 제목을 입력해주세요.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieSearchViewController {
    func didRetrieveMovieLists(data: [Movie]) {
        print(data.first!.title)
        self.dismissIndicator()
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieTableViewController") as? MovieTableViewController {
            vc.data = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter) {
        self.view.frame.origin.y -= 80
    }
    
    @objc func keyboardWillDisappear(_ sender: NotificationCenter) {
        self.view.frame.origin.y += 80
    }
}
