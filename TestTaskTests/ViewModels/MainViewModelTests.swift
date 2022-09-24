//
//  MainViewModelTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 24.09.2022.
//

import XCTest
import SwiftUI
import Combine
@testable import TestTask

class MainViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var networkingService: NetworkRequestExecutor!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        networkingService = NetworkRequestExecutor()
    }
    
    func testFetchPeople() throws {
        let dataFetchable: DataFetchable = APIService(executor: networkingService)
        var response: People?
        var error: Error?
        
        dataFetchable
            .getPeopleList()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
            } receiveValue: { values in
                response = values
                response?.data.forEach { id in
                    try? self.testFetchPerson(personId: id)
                }
            }
            .store(in: &cancellables)
        
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.status, "success")
    }
    
    func testFetchPerson(personId: String) throws {
        let dataFetchable: DataFetchable = APIService(executor: networkingService)
        var response: PeopleDetails?
        var error: Error?
        
        dataFetchable
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
            } receiveValue: { values in
                response = values
            }
            .store(in: &cancellables)
        
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.status, "success")
    }
}
