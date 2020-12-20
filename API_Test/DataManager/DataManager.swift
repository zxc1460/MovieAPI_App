//
//  DataManager.swift
//  API_Test
//
//  Created by Seok on 2020/12/19.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire

class DataManager {
    static let shared = DataManager()
    
    func kakaoLogIn(_ viewController: LogInViewController) {
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
                print(error.localizedDescription)
                viewController.failedToLogIn(message: "로그인에 실패하였습니다.")
           }
           else {
                print("loginWithKakaoAccount() success.")
            
            //do something
                _ = oauthToken
                self.setUserInfo()
                viewController.successLogIn()
           }
        }
    }
    
    private func setUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            } else {
                Constants.name = user?.kakaoAccount?.profile?.nickname
                Constants.profileImageUrl = user?.kakaoAccount?.profile?.profileImageUrl
            }
        }
    }
    
    func kakaoLogOut(_ viewController: HomeViewController) {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
                viewController.failedToLogOut(message: "로그아웃에 실패하였습니다.")
            } else {
                print("log out success")
                viewController.successLogOut()
            }
        }
    }
    
    func kakaoLogOut(_ sceneDelegate: SceneDelegate, logInValidateTime: Date) {
        let date = Date()
        if date > logInValidateTime {
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error.localizedDescription)
        
                } else {
                    
                }
            }
            
            sceneDelegate.successLogOut()
        }
    }
    
    func requestBoxOfficeData(day: String, viewController: BoxOfficeTableViewController) {
        let url = Constants.BOXOFFICE_BASE_URL + "?key=\(Keys.BOXOFFICE_KEY)" + "&targetDt=\(day)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: BoxOfficeResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                viewController.didRetrieveBoxOfficeData(data: response.boxOfficeResult.dailyBoxOfficeList)
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
    
    func requestMovieLists(title: String, viewController: MovieSearchViewController) {
        let urlString = Constants.NAVER_MOVIE_SEARCH_BASE_URL + "?query=\(title)"
        let headers: HTTPHeaders = ["X-Naver-Client-Id": Keys.NAVER_CLIENT_ID, "X-Naver-Client-Secret": Keys.NAVER_CLIENT_SECRET]
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encoded) {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: MovieResponse.self) { (response) in
                switch response.result {
                case .success(let response):
                    viewController.didRetrieveMovieLists(data: response.items)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
        } else {
            viewController.failedToRequest(message: "검색어를 제대로 입력해주세요")
        }
    }

}
