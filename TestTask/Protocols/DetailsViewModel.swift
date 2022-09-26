//
//  DetailsViewModel.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

protocol DetailsViewModel: ObservableObject {
    func fetchPerson(personId: String)
}
