//
//  SocialMenuProvider.swift
//  MSGP
//
//  Created by Igor Popov on 7/13/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import Foundation

class SocialMenuItemsProvider: SideMenuItemsProvider {
    
    weak var coordinator: CrossModuleCoordinator!
    
    init(coordinator: CrossModuleCoordinator) {
        self.coordinator = coordinator
    }
    
    enum State: Int {
        case authenticated, unauthenticated
    }
    
    enum Route: Int {
        case home, signin
    }
    
    var state: State {
        if SocialPlus.shared.modelStack != nil {
            return .authenticated
        } else {
            return .unauthenticated
        }
    }
    
    typealias ModuleBuilder = (_ coordinator: CrossModuleCoordinator) -> UIViewController
    
    static var builderForSignIn: ModuleBuilder = { coordinator in
        
        let module = LoginConfigurator()
        module.configure(moduleOutput: coordinator)
        return module.viewController
    }
    
    static var builderForDummy: ModuleBuilder = { coordinator in
        return UIViewController()
    }
    
    var items = [State.authenticated: [
        (title: "Home", image: UIImage(asset: Asset.iconLiked), builder: builderForSignIn),
         (title: "Search", image: UIImage(asset: Asset.iconSearch), builder: builderForDummy),
         (title: "Popular", image: UIImage(asset: Asset.iconPopular), builder: builderForDummy),
         (title: "My pins", image: UIImage(asset: Asset.iconPins), builder: builderForDummy),
         (title: "Activity Feed", image: UIImage(asset: Asset.iconActivity), builder: builderForDummy),
         (title: "Settings", image: UIImage(asset: Asset.iconSettings), builder: builderForDummy),
         (title: "Log out", image: UIImage(asset: Asset.iconLogout), builder: builderForDummy)
        ], State.unauthenticated: [
        (title: "Search", image: UIImage(asset: Asset.iconSearch), builder: builderForSignIn),
        (title: "Popular", image: UIImage(asset: Asset.iconLiked), builder: builderForSignIn)
    ]]
    
    func numberOfItems() -> Int {
        return items[state]!.count
    }
    
    func image(forItem index: Int) -> UIImage {
        return items[state]![index].image
    }
    
    func title(forItem index: Int) -> String {
        return items[state]![index].title
    }
    
    @objc func test() -> UIViewController {
        return UIViewController()
    }
    
    func destination(forItem index: Int) -> UIViewController {
        
        guard let builder = items[.authenticated]?[index].builder else {
            return UIViewController()
        }
        
        return builder(self.coordinator)
    }
}
