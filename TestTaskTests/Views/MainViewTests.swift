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
        let viewModel = MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)
        
        viewModel.people = [:]
        viewModel.currentState = .empty
        
        let image = try? sut.inspect().find(viewWithTag: "main_image_empty_list")
        let text = try? sut.inspect().find(text: "main_text_empty")
        
        XCTAssertNotNil(image)
        XCTAssertNotNil(text)
    }
    
    func testMainViewListState() throws {
        let viewModel = MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)
        
        viewModel.fetchPeople()
        viewModel.currentState = .list
        
        let backgroundColor = try? sut.inspect().find(viewWithTag: "main_background")
        let backgroundNavBar = try? sut.inspect().find(viewWithTag: "main_background_navbar")
        
        XCTAssertNotNil(backgroundColor)
        XCTAssertNotNil(backgroundNavBar)
    }
    
    func testMainViewErrorState() throws {
        let viewModel = MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)
        
        viewModel.fetchPeople()
        viewModel.currentState = .error
        
        let textFaildLoad = try? sut.inspect().find(text: "main_text_error").string()
        XCTAssertNotNil(textFaildLoad)
        XCTAssertEqual(textFaildLoad, "main_text_error")
        
        let btnTryAgain = try? sut.inspect().find(text: "main_text_try_again").string()
        XCTAssertNotNil(btnTryAgain)
        XCTAssertEqual(btnTryAgain, "main_text_try_again")
    }
    
    func testNavLinkTap() throws {
        let viewModel = MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)
        
        viewModel.fetchPeople()
        viewModel.currentState = .list
        
        let navLink = try? sut.inspect().find(button: "main_navlink")
        try navLink?.tap()
    }
    
    func testButtonTryAgainTap() throws {
        let viewModel = MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let sut = MainView(viewModel: viewModel)
        
        viewModel.fetchPeople()
        viewModel.currentState = .error
        
        let button = try? sut.inspect().find(button: "main_text_try_again")
        try button?.tap()
    }
}
