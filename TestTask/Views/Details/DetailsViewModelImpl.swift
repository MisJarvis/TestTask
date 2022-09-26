//
//  DetailsViewModelImpl.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation
import Combine
import LoggerAPI

class DetailsViewModel: ObservableObject {
    @Published var person: Person?
    @Published var currentState: ViewState = .empty
    
    func fetchPerson(personId: String) {}
}

class DetailsViewModelImpl: DetailsViewModel {
    
    private var dataFetchable: DataFetchable
    private var cancellables = Set<AnyCancellable>()
    
    init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init()
    }
    
    override func fetchPerson(personId: String) {
        self.dataFetchable
            .getPeopleDetails(id: personId)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                self.currentState = .error(errorState: error)
                Log.error("Get Person Data Error: \(error)")
            } receiveValue: { [weak self] person in
                guard let self = self else {return}
                self.person = person
                self.currentState = .dataReceived
            }
            .store(in: &cancellables)
    }
}
