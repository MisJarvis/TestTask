//
//  Person.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation

// MARK: - Person

struct Person: Codable, Identifiable {
    var id: String = String()
    var firstName: String = String()
    var lastName: String = String()
    var age: Int = Int()
    var gender: String = String()
    var country: String = String()
}
