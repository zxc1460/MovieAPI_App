//
//  HomeViewController.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import UIKit
import KakaoSDKUser

class HomeViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func logOutButtonTapped(_ sender: Any) {
        let alertVC = UIAlertController(title: "정말 로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "예", style: .default, handler: { (action) in
            DataManager.shared.kakaoLogOut(self)
        }))
        alertVC.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = 100
        
        if let name = Constants.name {
            nameLabel.text = name + " 님 환영합니다"
        }
        
        if let url = Constants.profileImageUrl {
            DispatchQueue(label: "background").async {
                do {
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

extension HomeViewController {
    func successLogOut() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToLogOut(message: String) {
        self.presentAlert(title: message)
    }
}
