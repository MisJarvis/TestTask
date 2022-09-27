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
        let viewModel = DetailsViewModel(person: nil)
        let sut = DetailsView(viewModel: viewModel)
        
        viewModel.currentState = .empty
        
        let image = try? sut.inspect().find(viewWithTag: "details_image_empty_list")
        let text = try? sut.inspect().find(text: "details_text_empty")
        
        XCTAssertNotNil(image)
        XCTAssertNotNil(text)
    }
    
    func testDetailsViewListState() throws {
        let viewModel = DetailsViewModel(person: Details(
            id: "1111",
            firstName: "First Name",
            lastName: "Last Name",
            age: 15,
            gender: "Famele",
            country: "Ukraine"
        ))
        let sut = DetailsView(viewModel: viewModel)
        
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
}
