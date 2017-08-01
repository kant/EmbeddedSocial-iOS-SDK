//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

class HomeRouter: HomeRouterInput {
    
    weak var viewController: UIViewController?
    
    func open(route: HomeRoutes, post: Post) {
        let configurator = PostDetailModuleConfigurator()
        let vc = StoryboardScene.PostDetail.instantiatePostDetailViewController()
        configurator.configure(viewController: vc, post: post)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
