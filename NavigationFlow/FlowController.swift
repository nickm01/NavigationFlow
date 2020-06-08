//
//  FlowController.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation

class FlowController {

    var view: FlowControllerView?
    init() {
        self.view = FlowControllerView(modelDelegate: self)
    }
}

extension FlowController: FlowControllerViewDelegate {
    func didTapNextFromScreen1() {
        // Do some network actions... then
        view?.navigate(to: .screen2)
    }

    func didTapNextFromScreen2() {
        // Do some network actions... then
        view?.navigate(to: .screen3)
    }

    func didTapNextAFromScreen3() {
        // Do some network actions... then
        view?.navigate(to: .screen4)
    }

    func didTapNextBFromScreen3() {
        // Do some network actions... then
        view?.navigate(to: .finalFrom3)
    }

    func didTapNextFromScreen4() {
        // Do some network actions... then
        view?.navigate(to: .finalFrom4)
    }
}

