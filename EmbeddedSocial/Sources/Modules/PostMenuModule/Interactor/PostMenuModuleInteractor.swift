//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

protocol PostMenuModuleInteractorInput {

    func block(user: UserHandle)
    func unblock(user: UserHandle)
    func repost(user: UserHandle)
    func follow(user: UserHandle)
    func unfollow(user: UserHandle)
    func hide(post: PostHandle)
    func edit(post: PostHandle)
    func remove(post: PostHandle)
    func report(post: PostHandle)
    
}

protocol PostMenuModuleInteractorOutput: class {
    
    func didBlock(user: UserHandle, error: Error?)
    func didUnblock(user: UserHandle, error: Error?)
    func didRepost(user: UserHandle, error: Error?)
    func didFollow(user: UserHandle, error: Error?)
    func didUnfollow(user: UserHandle, error: Error?)
    func didHide(post: PostHandle, error: Error?)
    func didEdit(post: PostHandle, error: Error?)
    func didRemove(post: PostHandle, error: Error?)
    func didReport(post: PostHandle, error: Error?)
    
}

class PostMenuModuleInteractor: PostMenuModuleInteractorInput {
    
    weak var output: PostMenuModuleInteractorOutput!
    var socialService: SocialServiceType!
    var topicsService: PostServiceProtocol!
    
    // MARK: Input
    
    func follow(user: UserHandle) {
     
        socialService.follow(userID: user) { [weak self] (result) in
            self?.output.didFollow(user: user, error: result.error)
        }
    }
    
    func unfollow(user: UserHandle) {
        
        socialService.unfollow(userID: user) { [weak self] (result) in
            self?.output.didUnfollow(user: user, error: result.error)
        }
    }
    
    func remove(post: PostHandle) {
        
        topicsService.deletePost(post: post) { [weak self] (result) in
            self?.output.didRemove(post: post, error: result.error)
        }
    }
    
    func block(user: UserHandle) {
        
        socialService.block(userID: user) { [weak self] (result) in
            self?.output.didBlock(user: user, error: result.error)
        }
    }
    
    func unblock(user: UserHandle) {
        
        socialService.unblock(userID: user) { [weak self] (result) in
            self?.output.didUnblock(user: user, error: result.error)
        }
    }
    
    func edit(post: PostHandle) {
        self.output.didEdit(post: post, error: nil)
    }
    
    func hide(post: PostHandle) {
        
        socialService.deletePostFromMyFollowing(postID: post) { (result) in
            self.output.didHide(post: post, error: result.error)
        }
    }
    
    func repost(user: UserHandle) {
        self.output.didRepost(user: user, error: nil)
    }
    
    func report(post: PostHandle) {
        self.output.didReport(post: post, error: nil)
    }
}