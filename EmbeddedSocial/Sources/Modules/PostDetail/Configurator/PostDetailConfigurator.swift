//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit

class PostDetailModuleConfigurator {

    func configure(viewController: PostDetailViewController, post: Post, cache: Cache = SocialPlus.shared.cache) {

        let router = PostDetailRouter()

        let presenter = PostDetailPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.post = post

        let interactor = PostDetailInteractor()
        interactor.output = presenter
        let commentsService = CommentsService(cache: cache)
        interactor.commentsService = commentsService
        let likeService = LikesService()
        interactor.likeService = likeService

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
