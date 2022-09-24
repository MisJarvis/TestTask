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
    
    func getPeopleList() -> AnyPublisher<People, Error> {
        return executor.executeRequest(
            path: "/list",
            method: .get
        )
    }
    
    func getPeopleDetails(id: String) -> AnyPublisher<PeopleDetails, Error> {
        return executor.executeRequest(
            path: "/get/\(id)",
            method: .get
        )
    }
}
