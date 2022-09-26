//
//  DomainModelConvertible.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

protocol DomainModelConvertible {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
