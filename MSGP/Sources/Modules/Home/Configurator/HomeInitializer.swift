//
//  HomeHomeInitializer.swift
//  MSGP-Framework
//
//  Created by igor.popov on 21/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import UIKit

class HomeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var homeViewController: HomeViewController!

    override func awakeFromNib() {

        let configurator = HomeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: homeViewController)
    }

}
