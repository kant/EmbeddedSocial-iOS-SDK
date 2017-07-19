//
//  SocialPlus.swift
//  MSGP
//
//  Created by Vadim Bulavin on 7/10/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import Foundation

struct LaunchArguments {
    let app: UIApplication
    let window: UIWindow
    let launchOptions: [AnyHashable: Any]
}

public final class SocialPlus {
    private var launchArguments: LaunchArguments!
    private var root: RootConfigurator!
    private let urlSchemeService = URLSchemeService()
    
    private(set) var modelStack: ModelStack!
    
    public static let shared = SocialPlus()
    
    private init() { }
    
    public func start(with application: UIApplication,
                      window: UIWindow,
                      launchOptions: [AnyHashable: Any],
                      menuHandler: SideMenuItemsProvider?,
                      menuConfiguration: SideMenuType) {
        
        navigationStack = NavigationStack(window: window, format: menuConfiguration, menuItemsProvider: menuHandler)
        
        launchArguments = LaunchArguments(app: application, window: window, launchOptions: launchOptions)
        
        ThirdPartyConfigurator.setup(application: launchArguments.app, launchOptions: launchArguments.launchOptions)
        
//        root.router.onSessionCreated = { [unowned self] user, sessionToken in
//            self.modelStack = ModelStack(user: user, sessionToken: sessionToken)
//            self.root.router.openHomeScreen(user: user)
//        }
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [AnyHashable: Any]) -> Bool {
        return urlSchemeService.application(app, open: url, options: options)
    }
    
    // MARK: menu
    
    var navigationStack: NavigationStack?
    
}