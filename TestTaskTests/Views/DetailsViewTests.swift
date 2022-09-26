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
        let viewModel = DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let personId = String()
        let sut = DetailsView(viewModel: viewModel, personId: personId)
        
        viewModel.person = nil
        viewModel.currentState = .empty
        
        let image = try? sut.inspect().find(viewWithTag: "details_image_empty_list")
        let text = try? sut.inspect().find(text: "details_text_empty")
        
        XCTAssertNotNil(image)
        XCTAssertNotNil(text)
    }
    
    func testDetailsViewListState() throws {
        let viewModel = DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let personId = String()
        let sut = DetailsView(viewModel: viewModel, personId: personId)
        
        viewModel.fetchPerson(personId: personId)
        viewModel.currentState = .list
        
        viewModel.person = Person()
        
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
        let viewModel = DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let personId = String()
        let sut = DetailsView(viewModel: viewModel, personId: personId)
        
        viewModel.fetchPerson(personId: personId)
        viewModel.currentState = .error
        
        let textFaildLoad = try? sut.inspect().find(text: "details_text_error").string()
        XCTAssertNotNil(textFaildLoad)
        XCTAssertEqual(textFaildLoad, "details_text_error")
        
        let btnTryAgain = try? sut.inspect().find(text: "details_text_try_again").string()
        XCTAssertNotNil(btnTryAgain)
        XCTAssertEqual(btnTryAgain, "details_text_try_again")
    }
    
    func testButtonTryAgainTap() throws {
        let viewModel = DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor()))
        let personId = String()
        let sut = DetailsView(viewModel: viewModel, personId: personId)
        
        viewModel.fetchPerson(personId: personId)
        viewModel.currentState = .error
        
        let button = try? sut.inspect().find(button: "details_text_try_again")
        try button?.tap()
    }
}
