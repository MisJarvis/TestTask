//
//  PersonDTO.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation

struct PersonDTO: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let country: String
}

extension PersonDTO: DomainModelConvertible {
    func toDomainModel() -> Person {
        return Person(
            id: self.id,
            firstName: self.firstName,
            lastName: self.lastName,
            age: self.age,
            gender: self.gender,
            country: self.country
        )
    }
}
