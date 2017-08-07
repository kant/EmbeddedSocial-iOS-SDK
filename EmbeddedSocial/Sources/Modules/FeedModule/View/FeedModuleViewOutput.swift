//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

protocol FeedModuleViewOutput {

    /**
        @author igor.popov
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func numberOfItems() -> Int
    func item(for path: IndexPath) -> PostViewModel
    
    func didTapChangeLayout()
    func didTapItem(path: IndexPath)
    
    func didAskFetchAll()
    func didAskFetchMore()

    func didScrollFeed(_ feedView: UIScrollView)
}