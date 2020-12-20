//
//  String.swift
//  API_Test
//
//  Created by Seok on 2020/12/19.
//

import Foundation

extension String {
    var tagRemoved: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
