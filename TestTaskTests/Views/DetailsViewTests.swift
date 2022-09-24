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

    func testDetailsView() {
        let executor = NetworkRequestExecutor()
        let networkingService = APIService(executor: executor)
        let viewModel = MainViewModel(networkingService: networkingService)
        let sut = DetailsView(viewModel: viewModel, personId: String())

        viewModel.fetchPeople()
        
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
