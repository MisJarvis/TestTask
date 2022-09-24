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
    
    func testMainViewDataCompleted() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        viewModel.fetchPeople()
        var sut = MainView()
        
        let exp = sut.on(\.didAppear) { view in
            
            let backgroundColor = try? view.find(viewWithTag: "main_background")
            let backgroundNavBar = try? view.find(viewWithTag: "main_background_navbar")
            
            XCTAssertNotNil(backgroundColor)
            XCTAssertNotNil(backgroundNavBar)
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
    
    func testMainViewDataNotCompleted() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        var sut = MainView()
        
        let exp = sut.on(\.didAppear) { view in
            let textFaildLoad = try? view.find(text: "Failed to load people list").string()
            XCTAssertNotNil(textFaildLoad)
            XCTAssertEqual(textFaildLoad, "Failed to load people list")
            
            let btnTryAgain = try? view.find(text: "Try again").string()
            XCTAssertNotNil(btnTryAgain)
            XCTAssertEqual(btnTryAgain, "Try again")
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
    
    func testNavLinkTap() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        viewModel.fetchPeople()
        var sut = MainView()
        
        let exp = sut.on(\.didAppear) { view in
            let navLink = try? view.find(button: "main_navlink")
            try navLink?.tap()
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
    
    func testButtonTryAgainTap() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        var sut = MainView()
        
        let exp = sut.on(\.didAppear) { view in
            viewModel.people = [:]
            
            let button = try? view.find(button: "Try again")
            try button?.tap()
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
}
