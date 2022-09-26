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
        let sut = DetailsViewModelImpl(dataFetchable: mockDataFetchable)
        
        XCTAssertNil(sut.person)
        guard case .empty = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
    
    func testFetchPeopleDetailsSuccess() throws {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.person = Person(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        let sut = DetailsViewModelImpl(dataFetchable: mockDataFetchable)
        sut.fetchPerson(personId: "1111")
        
        XCTAssertNotNil(sut.person)
        guard case .dataReceived = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
    
    func testFetchPeopleDetailsError() throws {
        let mockDataFetchable = MockDataFetchable()
        let sut = DetailsViewModelImpl(dataFetchable: mockDataFetchable)
        sut.fetchPerson(personId: "1111")
        
        XCTAssertNil(sut.person)
        guard case .error(let error) = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
        XCTAssertEqual(error.localizedDescription, "Data person is empty")
    }
}
