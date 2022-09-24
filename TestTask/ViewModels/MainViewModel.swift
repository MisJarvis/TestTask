//
//  MainViewModel.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation
import Combine
import LoggerAPI

class MainViewModel: ObservableObject {
    
    private var dataFetchable: DataFetchable
    private var cancellables = Set<AnyCancellable>()
    
    @Published var people: [String: String] = [:]
    @Published var person: Person?
    
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
                case .failure(let error):
                    Log.error("Get People List Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                let list = values.data
                list.forEach { id in
                    self.fetchPeopleDetails(personId: id)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPeopleDetails(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    Log.error("Get People List Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                let key = values.data.id
                let value = values.data.firstName
                self.people[key] = value
            }
            .store(in: &cancellables)
    }
    
    func fetchPerson(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    Log.error("Get Person Data Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                self.person = values.data
            }
            .store(in: &cancellables)
    }
}
