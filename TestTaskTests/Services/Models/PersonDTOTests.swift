//
//  PersonDTOTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 27.09.2022.
//

import XCTest
@testable import TestTask

class DetailsDTOTests: XCTestCase {
    
    func testToDomainModel() throws {
        let detailsDTO = DetailsDTO(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        let details = Details(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        XCTAssertEqual(detailsDTO.toDomainModel(), details)
    }
}
