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
    
    func testMainViewEmptyState() throws {
        let mockDataFetchable = MockDataFetchable()
        let viewModel = MainViewModel(dataFetchable: mockDataFetchable)
        let sut = MainView(viewModel: viewModel)
        
        viewModel.people = []
        viewModel.currentState = .empty
        
        let image = try? sut.inspect().find(viewWithTag: "main_image_empty_list")
        let text = try? sut.inspect().find(text: "main_text_empty")
        
        XCTAssertNotNil(image)
        XCTAssertNotNil(text)
    }
    
    func testMainViewListState() throws {
        let mockDataFetchable = MockDataFetchable()
        let viewModel = MainViewModel(dataFetchable: mockDataFetchable)
        let sut = MainView(viewModel: viewModel)
        
        viewModel.people = [Person(
            id: "1111",
            details: Details(
                id: "1111",
                firstName: "First Name",
                lastName: "Last Name",
                age: 15,
                gender: "Famele",
                country: "Ukraine"
            )
        )]
        viewModel.currentState = .dataReceived
        
        let backgroundColor = try? sut.inspect().find(viewWithTag: "main_background")
        let backgroundNavBar = try? sut.inspect().find(viewWithTag: "main_background_navbar")
        
        XCTAssertNotNil(backgroundColor)
        XCTAssertNotNil(backgroundNavBar)
    }
    
    func testMainViewErrorState() throws {
        let mockDataFetchable = MockDataFetchable()
        let viewModel = MainViewModel(dataFetchable: mockDataFetchable)
        let sut = MainView(viewModel: viewModel)
        
        viewModel.currentState = .error(errorState: RuntimeError("Failed to load data"))
        
        let titleError = try? sut.inspect().find(text: "main_title_error").string()
        XCTAssertNotNil(titleError)
        XCTAssertEqual(titleError, "main_title_error")
        
        let textError = try? sut.inspect().find(viewWithTag: "main_text_error")
        XCTAssertNotNil(textError)
        
        let btnTryAgain = try? sut.inspect().find(text: "main_text_try_again").string()
        XCTAssertNotNil(btnTryAgain)
        XCTAssertEqual(btnTryAgain, "main_text_try_again")
    }
    
    func testNavLinkTap() throws {
        let mockDataFetchable = MockDataFetchable()
        let viewModel = MainViewModel(dataFetchable: mockDataFetchable)
        let sut = MainView(viewModel: viewModel)
        
        viewModel.people = [Person(
            id: "1111",
            details: Details(
                id: "1111",
                firstName: "First Name",
                lastName: "Last Name",
                age: 15,
                gender: "Famele",
                country: "Ukraine"
            )
        )]
        viewModel.currentState = .dataReceived
        
        let navLink = try? sut.inspect().find(button: "main_navlink")
        try navLink?.tap()
    }
    
    func testButtonTryAgainTap() throws {
        let mockDataFetchable = MockDataFetchable()
        let viewModel = MainViewModel(dataFetchable: mockDataFetchable)
        let sut = MainView(viewModel: viewModel)
        
        viewModel.currentState = .error(errorState: RuntimeError("Failed to load data"))
        
        let button = try? sut.inspect().find(button: "main_text_try_again")
        try button?.tap()
    }
}
