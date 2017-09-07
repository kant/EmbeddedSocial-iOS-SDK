//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

class FollowingPresenter: FollowingViewOutput {
    weak var view: FollowingViewInput!
    var usersList: UserListModuleInput!
    weak var moduleOutput: FollowingModuleOutput?

    func viewIsReady() {
        view.setupInitialState(userListView: usersList.listView)
        usersList.setupInitialState()
    }
}

extension FollowingPresenter: UserListModuleOutput {
    func didFailToPerformSocialRequest(listView: UIView, error: Error) {
        view.showError(error)
    }
    
    func didFailToLoadList(listView: UIView, error: Error) {
        view.showError(error)
    }
    
    func didUpdateFollowStatus(for user: User) {
        guard let followStatus = user.followerStatus else { return }
        moduleOutput?.didUpdateFollowingStatus(newStatus: followStatus)
    }
}
