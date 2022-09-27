//
//  Person.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

struct Person: Hashable {
    let id: String
    let details: Details
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
