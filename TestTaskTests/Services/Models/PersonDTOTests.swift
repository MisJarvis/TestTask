//
//  PersonDTOTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 27.09.2022.
//

import XCTest
@testable import TestTask

class PersonDTOTests: XCTestCase {
    
    func testToDomainModel() throws {
        let personDTO = PersonDTO(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        let person = Person(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        XCTAssertEqual(personDTO.toDomainModel(), person)
    }
}
