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
    
    var dataFetchable: DataFetchable
    
    @Published var people: [String: String] = [:]
    @Published var person: Person?
    @Published var currentState: ViewState = .loading
    
    init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        self.fetchPeople()
    }
    
    func fetchPeople() {}
}

class MainViewModelImpl: MainViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func fetchPeople() {
        self.dataFetchable
            .getPeopleList()
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                self.currentState = .error(errorState: error)
                Log.error("Get People List Error: \(error)")
            } receiveValue: { [weak self] list in
                guard let self = self else { return }
                if list.isEmpty {
                    self.currentState = .empty
                } else {
                    self.currentState = .dataReceived
                    list.forEach { id in
                        self.fetchPerson(personId: id)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchPerson(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                Log.error("Get Person Data Error: \(error)")
            } receiveValue: { [weak self] person in
                guard let self = self else { return }
                let key = person.id
                let value = person.firstName
                self.people[key] = value
                
                self.person = person
            }
            .store(in: &cancellables)
    }
}
