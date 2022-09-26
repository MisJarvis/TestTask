//
//  MainViewModelImpl.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation
import Combine
import LoggerAPI

class MainViewModelImpl: MainViewModel {
    
    @Published var people: [String: String] = [:]
    @Published var person: Person?
    @Published var currentState: ViewState = .empty
    @Published var error: Error?
    
    private var dataFetchable: DataFetchable
    private var cancellables = Set<AnyCancellable>()
    
    init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        self.fetchPeople()
    }
    
    func fetchPeople() {
        self.dataFetchable
            .getPeopleList()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let errorData):
                    self.error = ErrorState.peopleList
                    self.currentState = .error
                    Log.error("Get People List Error: \(errorData)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                let list = values.data
                if list.isEmpty {
                    self.currentState = .empty
                } else {
                    self.currentState = .list
                    list.forEach { id in
                        self.fetchPerson(personId: id)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPerson(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let errorData):
                    self.error = ErrorState.peopleList
                    Log.error("Get Person Data Error: \(errorData)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                let key = values.data.id
                let value = values.data.firstName
                self.people[key] = value
                
                self.person = values.data
            }
            .store(in: &cancellables)
    }
}
