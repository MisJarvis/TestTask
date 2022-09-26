//
//  ErrorState.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

enum ErrorState: LocalizedError {
    case peopleList
    case peopleDetails

    var errorDescription: String? {
        switch self {
        case .peopleList:
            return "alert_title_error".localized
        case .peopleDetails:
            return "alert_title_error".localized
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .peopleList:
            return "alert_error_people_list".localized
        case .peopleDetails:
            return "alert_error_details_person".localized
        }
    }
}
