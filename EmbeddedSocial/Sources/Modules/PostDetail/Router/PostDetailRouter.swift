//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import SKPhotoBrowser

class PostDetailRouter: PostDetailRouterInput {
    weak var loginOpener: LoginModalOpener?
    weak var navigationController: UINavigationController?
    
    func openLogin(from view: UIViewController) {
        loginOpener?.openLogin(parentViewController: view.navigationController)
    }
}
