//
//  MainViewTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 24.09.2022.
//

import XCTest
import ViewInspector
@testable import TestTask

extension MainView: Inspectable {}

class MainViewTests: XCTestCase {

    func testMainView() {
        let executor = NetworkRequestExecutor()
        let networkingService = APIService(executor: executor)
        let viewModel = MainViewModel(networkingService: networkingService)
        let sut = MainView(viewModel: viewModel)

        viewModel.fetchPeople()
        
        let backgroundColor = try? sut.inspect().find(viewWithTag: "main_background")
        let backgroundNavBar = try? sut.inspect().find(viewWithTag: "main_background_navbar")
        let labelPerson = try? sut.inspect().find(viewWithTag: "main_label_person")
        let navLink = try? sut.inspect().find(viewWithTag: "main_navlink")

        XCTAssertNotNil(backgroundColor)
        XCTAssertNotNil(backgroundNavBar)
        XCTAssertNotNil(labelPerson)
        XCTAssertNotNil(navLink)
    }

    func testNavLinkTap() throws {
        let viewModel = MainViewModel(networkingService: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)

        let navLink = try? sut.inspect().find(button: "main_navlink")
        try navLink?.tap()
    }
}
