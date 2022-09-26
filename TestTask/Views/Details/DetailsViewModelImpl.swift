//
//  DetailsViewModelImpl.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation
import Combine
import LoggerAPI

class DetailsViewModelImpl: DetailsViewModel {
    
    @Published var person: Person?
    @Published var currentState: ViewState = .list
    @Published var error: Error?
    
    private var dataFetchable: DataFetchable
    private var cancellables = Set<AnyCancellable>()
    
    init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
    }
    
    func fetchPerson(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let errorData):
                    self.error = ErrorState.peopleDetails
                    self.currentState = .error
                    Log.error("Get Person Data Error: \(errorData)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                guard let self = self else {return}
                self.person = values.data
                self.currentState = .list
            }
            .store(in: &cancellables)
    }
}
