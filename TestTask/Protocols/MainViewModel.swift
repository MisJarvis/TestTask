//
//  MainViewModel.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

protocol MainViewModel: ObservableObject {
    func fetchPeople()
    func fetchPerson(personId: String)
}
