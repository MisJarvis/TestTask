//
//  DetailsViewModel.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation
import Combine
import LoggerAPI

class DetailsViewModel: ObservableObject {
    @Published var person: Details?
    @Published var currentState: ViewState = .loading
    
    init(person: Details?) {
        self.person = person
        
        if person != nil {
            self.currentState = .dataReceived
        } else {
            self.currentState = .empty
        }
    }
}
