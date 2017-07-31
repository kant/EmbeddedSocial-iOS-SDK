//
//  PostDetailPostDetailViewController.swift
//  EmbeddedSocial-Framework
//
//  Created by generamba setup on 31/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, PostDetailViewInput {

    var output: PostDetailViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: PostDetailViewInput
    func setupInitialState() {
    }
}
