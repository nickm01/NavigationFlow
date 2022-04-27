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
        XCTAssertFalse(sut.navigateTo2)
        let screen1VM = sut.makeScreen1PhoneVM()
        screen1VM.didTapNext()
        XCTAssertFalse(sut.navigateTo2)
    }

    func test_navigates_whenTapNextAndPhoneNumberValid() throws {
        let sut = FlowVM()
        XCTAssertFalse(sut.navigateTo2)
        let screen1VM = sut.makeScreen1PhoneVM()
        screen1VM.phoneNumber = "5555555555"
        screen1VM.didTapNext()
        XCTAssertTrue(sut.navigateTo2)
    }
}
