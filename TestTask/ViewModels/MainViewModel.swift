//
//  MainViewModel.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private var networkingService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var people: [String] = []
    @Published var person: Person = Person()
    
    init(networkingService: APIService) {
        self.networkingService = networkingService
        self.fetchPeopleList()
    }
    
    func fetchPeopleList() {
        self.networkingService
            .getPeopleList()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Get People List Error: \(error)")
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                
                self.people = values.data
            }
            .store(in: &cancellables)
    }
    
    func fetchPeopleList(personId: String) {
        self.networkingService
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Get People Details Error: \(error)")
                    break
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
