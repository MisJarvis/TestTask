//
//  APIService.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation
import Combine

class APIService: DataFetchable {
    let executor: NetworkRequestExecutor
    
    init(executor: NetworkRequestExecutor) {
        self.executor = executor
    }
    
    func getPeopleList() -> AnyPublisher<[String], Error> {
        func request() -> AnyPublisher<NetworkResponse<[String]>, Error> {
            return executor.executeRequest(
                path: "/list",
                method: .get
            )
        }
        
        return request()
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    func getPeopleDetails(id: String) -> AnyPublisher<Person, Error> {
        func request() -> AnyPublisher<NetworkResponse<PersonDTO>, Error> {
            return executor.executeRequest(
                path: "/get/\(id)",
                method: .get
            )
        }
        
        return request()
            .map { $0.data.toDomainModel() }
            .eraseToAnyPublisher()
    }
}
