//
//  MainViewModelTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 24.09.2022.
//

import XCTest
import SwiftUI
@testable import TestTask

class MainViewModelTests: XCTestCase {
    
    func testFetchPeopleListError() throws {
        let mockDataFetchable = MockDataFetchable()
        let sut = MainViewModelImpl(dataFetchable: mockDataFetchable)
        
        XCTAssertNil(sut.person)
        XCTAssertTrue(sut.people.isEmpty)
        guard case .error(let error) = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
        XCTAssertEqual(error.localizedDescription, "List is empty")
    }
    
    func testFetchPeopleListSuccessAndFetchPeopleDetailsError() throws {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.peopleList = ["1111", "2222", "3333"]
        
        let sut = MainViewModelImpl(dataFetchable: mockDataFetchable)
        
        XCTAssertNil(sut.person)
        XCTAssertTrue(sut.people.isEmpty)
        guard case .dataReceived = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
    
    func testFetchPeopleListSuccessAndFetchPeopleDetailsSuccess() {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.peopleList = ["1111", "2222", "3333"]
        mockDataFetchable.person = Person(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        
        let sut = MainViewModelImpl(dataFetchable: mockDataFetchable)
        
        XCTAssertNotNil(sut.person)
        XCTAssertFalse(sut.people.isEmpty)
        guard case .dataReceived = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
    
    func testFetchPeopleListEmpty() {
        let mockDataFetchable = MockDataFetchable()
        mockDataFetchable.peopleList = []
        
        let sut = MainViewModelImpl(dataFetchable: mockDataFetchable)
        
        XCTAssertNil(sut.person)
        XCTAssertTrue(sut.people.isEmpty)
        guard case .empty = sut.currentState else {
            XCTFail("Unexpected state")
            return
        }
    }
}
