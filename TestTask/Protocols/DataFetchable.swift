//
//  DataFetchable.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 24.09.2022.
//

import Foundation
import Combine

protocol DataFetchable {
    func getPeopleList() -> AnyPublisher<People, Error>
    func getPeopleDetails(id: String) -> AnyPublisher<PeopleDetails, Error>
}
