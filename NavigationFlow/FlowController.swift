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
    func didTapNext(request: NavigateTo) {
        // In the real world, would do a case statement here on the NavigateTo,
        // followed by potentially some network calls
        // before finally...
        view?.navigate(to: request)
    }
}

