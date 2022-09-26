//
//  ViewState.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

enum ViewState: Equatable {
    
    case empty
    case dataReceived
    case error(errorState: Error)

    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch(lhs, rhs) {
        case (.dataReceived, .dataReceived),
            (.empty, .empty),
            (.error, .error): return true
        default: return false
        }
    }
}
