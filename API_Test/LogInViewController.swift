//
//  LogInViewController.swift
//  API_Test
//
//  Created by Seok on 2020/10/26.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import SnapKit

class LogInViewController: UIViewController {

    @IBOutlet weak var kakaoLogInButton: UIButton!
    @IBAction func kakaoLogInButtonTapped(_ sender: Any) {
        DataManager.shared.kakaoLogIn(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        kakaoLogInButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
        }

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

extension LogInViewController {
    func successLogIn() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") {
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func failedToLogIn(message: String) {
        self.presentAlert(title: message)
    }
}
