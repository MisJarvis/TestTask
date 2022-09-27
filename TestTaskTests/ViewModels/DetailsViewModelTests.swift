//
//  DetailsViewModelTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import XCTest
import SwiftUI
@testable import TestTask

class DetailsViewModelTests: XCTestCase {
    
    func testFetchPeopleDetailsEmpty() throws {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.person = nil
        let sut = DetailsViewModel(person: mockDataFetchable.person)
        
        XCTAssertNil(sut.person)
        guard case .empty = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
    
    func testFetchPeopleDetailsSuccess() throws {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.person = Details(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        let sut = DetailsViewModel(person: mockDataFetchable.person)
        
        XCTAssertNotNil(sut.person)
        guard case .dataReceived = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
}
