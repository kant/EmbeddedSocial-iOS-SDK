//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

class SideMenuRouter: SideMenuRouterInput {
    
    var output: SideMenuModuleOutput!
    weak var coordinator: CrossModuleCoordinator!
    
    func open(viewController: UIViewController, sender: Any?) {
        closeMenu()
        output.show(viewController: viewController)
    }
 
    func openLogin() {
        
        closeMenu()
        let module = LoginConfigurator()
        module.configure(moduleOutput: coordinator)
        open(viewController: module.viewController, sender: nil)
    }
    
    private func closeMenu() {
        UIApplication.shared.sendAction(Selector(("closeSideMenu")), to: nil, from: self, for: nil)
    }
}
