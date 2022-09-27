//
//  MockDataFetchable.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import XCTest
import SwiftUI
import Combine
@testable import TestTask

class MockDataFetchable: DataFetchable {
    
    var peopleList: [String]?
    var person: Details?
    
    func getPeopleList() -> AnyPublisher<[String], Error> {
        return Future<[String], Error> { promise in
            if let list = self.peopleList {
                promise(.success(list))
            } else {
                promise(.failure(RuntimeError("List is empty")))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getPeopleDetails(id: String) -> AnyPublisher<Details, Error> {
        return Future<Details, Error> { promise in
            if let data = self.person {
                promise(.success(data))
            } else {
                promise(.failure(RuntimeError("Data person is empty")))
            }
        }
        .eraseToAnyPublisher()
    }
}
