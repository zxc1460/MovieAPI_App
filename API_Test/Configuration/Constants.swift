//
//  Constants.swift
//  API_Test
//
//  Created by Seok on 2020/10/26.
//

import Foundation
import AuthenticationServices

struct Constants {
    static let BOXOFFICE_BASE_URL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let BOXOFFICE_KEY: String = "35c4978bcb37c3fe0a064aa0d7675a1f"
    static let KAKAO_APP_KEY: String = "297829d49ad38dcb69cb1ef5220b1371"
    static let NAVER_MOVIE_SEARCH_BASE_URL: String = "https://openapi.naver.com/v1/search/movie.json"
    static let NAVER_CLIENT_ID: String = "uksIk5G0L5W3q6j3NEme"
    static let NAVER_CLIENT_SECRET: String = "Re9QqL1TfV"
    static var name: String?
    static var email: String?
    static var profileImageUrl: URL?
}
