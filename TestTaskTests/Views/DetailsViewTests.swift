//
//  DetailsViewTests.swift
//  TestTaskTests
//
//  Created by Yevstafieva Yevheniia on 24.09.2022.
//

import XCTest
import ViewInspector
@testable import TestTask

extension DetailsView: Inspectable {}

class DetailsViewTests: XCTestCase {
    
    func testDetailsViewDataCompleted() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        viewModel.fetchPeople()
        
        if let personId = viewModel.people.first?.key {
            var sut = DetailsView(personId: personId)
            
            let exp = sut.on(\.didAppear) { view in
                
                let backgroundColor = try? view.find(viewWithTag: "details_background")
                let backgroundNavBar = try? view.find(viewWithTag: "details_background_navbar")
                let imagePerson = try? view.find(viewWithTag: "details_image_person")
                let fullNamePerson = try? view.find(viewWithTag: "details_full_name_person")
                let agePerson = try? view.find(viewWithTag: "details_age_person")
                let genderPerson = try? view.find(viewWithTag: "details_gender_person")
                let countryPerson = try? view.find(viewWithTag: "details_country_person")
                
                XCTAssertNotNil(backgroundColor)
                XCTAssertNotNil(backgroundNavBar)
                XCTAssertNotNil(imagePerson)
                XCTAssertNotNil(fullNamePerson)
                XCTAssertNotNil(agePerson)
                XCTAssertNotNil(genderPerson)
                XCTAssertNotNil(countryPerson)
            }
            ViewHosting.host(view: sut.environmentObject(viewModel))
            wait(for: [exp], timeout: 1.0)
        }
    }
    
    func testDetailsViewDataNotCompleted() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        var sut = DetailsView(personId: String())
        
        let exp = sut.on(\.didAppear) { view in
            let textFaildLoad = try? view.find(text: "Failed to load person data").string()
            XCTAssertNotNil(textFaildLoad)
            XCTAssertEqual(textFaildLoad, "Failed to load person data")
            
            let btnTryAgain = try? view.find(text: "Try again").string()
            XCTAssertNotNil(btnTryAgain)
            XCTAssertEqual(btnTryAgain, "Try again")
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
    
    func testButtonTryAgainTap() throws {
        let viewModel = MainViewModel(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        var sut = DetailsView(personId: String())
        
        let exp = sut.on(\.didAppear) { view in
            
            let button = try? view.find(button: "Try again")
            try button?.tap()
        }
        ViewHosting.host(view: sut.environmentObject(viewModel))
        wait(for: [exp], timeout: 1.0)
    }
}
