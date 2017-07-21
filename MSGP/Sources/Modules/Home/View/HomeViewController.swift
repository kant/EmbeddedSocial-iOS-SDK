//
//  HomeHomeViewController.swift
//  MSGP-Framework
//
//  Created by igor.popov on 21/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {

    var output: HomeViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: HomeViewInput
    func setupInitialState() {
    }
}
