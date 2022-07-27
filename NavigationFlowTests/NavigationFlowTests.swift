//
//  NavigationFlowTests.swift
//  NavigationFlowTests
//
//  Created by Nick McConnell on 4/27/22.
//  Copyright © 2022 Nick McConnell. All rights reserved.
//

import XCTest
@testable import NavigationFlow

class NavigationFlowTests: XCTestCase {
    
    func test_doesNotNavigate_whenTapNextAndPhoneNumberValid() throws {
        let sut = FlowVM()
        XCTAssertEqual(sut.navigationPath.count, 0)
        let screen1VM = sut.makeScreen1PhoneVM()
        screen1VM.didTapNext()
        XCTAssertEqual(sut.navigationPath.count, 0)
    }

    func test_navigates_whenTapNextAndPhoneNumberValid() throws {
        let sut = FlowVM()
        XCTAssertEqual(sut.navigationPath.count, 0)
        let screen1VM = sut.makeScreen1PhoneVM()
        screen1VM.phoneNumber = "5555555555"
        screen1VM.didTapNext()
        XCTAssertEqual(sut.navigationPath.count, 1)
    }
}
