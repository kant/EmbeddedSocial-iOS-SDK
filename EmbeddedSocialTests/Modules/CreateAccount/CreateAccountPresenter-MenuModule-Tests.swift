//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest
@testable import EmbeddedSocial

class CreateAccountPresenter_MenuModule_Tests: XCTestCase {
    
    var sut: CreateAccountPresenter!
    var view: MockCreateAccountViewController!
    var interactor: MockCreateAccountInteractor!
    var router: MockCreateAccountRouter!
    var moduleOutput: MockCreateAccountModuleOutput!
    
    override func setUp() {
        super.setUp()
        
        let user = CreateAccountPresenterTests.initialSocialUser
        sut = CreateAccountPresenter(user: user)
        
        view = MockCreateAccountViewController()
        interactor = MockCreateAccountInteractor()
        router = MockCreateAccountRouter()
        moduleOutput = MockCreateAccountModuleOutput()
        
        sut.view = view
        sut.interactor = interactor
        sut.router = router
        sut.moduleOutput = moduleOutput
    }
    
    func test() {
        
    }

}
