//
//  PostDetailPostDetailConfiguratorTests.swift
//  EmbeddedSocial-Framework
//
//  Created by generamba setup on 31/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import XCTest

class PostDetailModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = PostDetailViewControllerMock()
        let configurator = PostDetailModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "PostDetailViewController is nil after configuration")
        XCTAssertTrue(viewController.output is PostDetailPresenter, "output is not PostDetailPresenter")

        let presenter: PostDetailPresenter = viewController.output as! PostDetailPresenter
        XCTAssertNotNil(presenter.view, "view in PostDetailPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in PostDetailPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is PostDetailRouter, "router is not PostDetailRouter")

        let interactor: PostDetailInteractor = presenter.interactor as! PostDetailInteractor
        XCTAssertNotNil(interactor.output, "output in PostDetailInteractor is nil after configuration")
    }

    class PostDetailViewControllerMock: PostDetailViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
