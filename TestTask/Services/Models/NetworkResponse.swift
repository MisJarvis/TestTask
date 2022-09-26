//
//  NetworkResponse.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    let status: String
    let data: T
}
