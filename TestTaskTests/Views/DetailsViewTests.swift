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
    
    func testDetailsViewEmptyState() throws {
        let viewModel = DetailsViewModel()
        let sut = DetailsView(viewModel: viewModel, personId: "1111")
        
        viewModel.person = nil
        viewModel.currentState = .empty
        
        let image = try? sut.inspect().find(viewWithTag: "details_image_empty_list")
        let text = try? sut.inspect().find(text: "details_text_empty")
        
        XCTAssertNotNil(image)
        XCTAssertNotNil(text)
    }
    
    func testDetailsViewListState() throws {
        let viewModel = DetailsViewModel()
        let sut = DetailsView(viewModel: viewModel, personId: "1111")
        
        viewModel.person = Person(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        )
        viewModel.currentState = .dataReceived
        
        let backgroundColor = try? sut.inspect().find(viewWithTag: "details_background")
        let backgroundNavBar = try? sut.inspect().find(viewWithTag: "details_background_navbar")
        let imagePerson = try? sut.inspect().find(viewWithTag: "details_image_person")
        let fullNamePerson = try? sut.inspect().find(viewWithTag: "details_full_name_person")
        let agePerson = try? sut.inspect().find(viewWithTag: "details_age_person")
        let genderPerson = try? sut.inspect().find(viewWithTag: "details_gender_person")
        let countryPerson = try? sut.inspect().find(viewWithTag: "details_country_person")
        
        XCTAssertNotNil(backgroundColor)
        XCTAssertNotNil(backgroundNavBar)
        XCTAssertNotNil(imagePerson)
        XCTAssertNotNil(fullNamePerson)
        XCTAssertNotNil(agePerson)
        XCTAssertNotNil(genderPerson)
        XCTAssertNotNil(countryPerson)
    }
    
    func testDetailsViewErrorState() throws {
        let viewModel = DetailsViewModel()
        let sut = DetailsView(viewModel: viewModel, personId: "1111")
        
        viewModel.currentState = .error(errorState: RuntimeError("Failed to load data"))
        
        let titleError = try? sut.inspect().find(text: "details_title_error").string()
        XCTAssertNotNil(titleError)
        XCTAssertEqual(titleError, "details_title_error")
        
        let textError = try? sut.inspect().find(viewWithTag: "details_text_error")
        XCTAssertNotNil(textError)
        
        let btnTryAgain = try? sut.inspect().find(text: "details_text_try_again").string()
        XCTAssertNotNil(btnTryAgain)
        XCTAssertEqual(btnTryAgain, "details_text_try_again")
    }
    
    func testButtonTryAgainTap() throws {
        let viewModel = DetailsViewModel()
        let sut = DetailsView(viewModel: viewModel, personId: "1111")
        
        viewModel.currentState = .error(errorState: RuntimeError("Failed to load data"))
  
        let button = try? sut.inspect().find(button: "details_text_try_again")
        try button?.tap()
    }
}
