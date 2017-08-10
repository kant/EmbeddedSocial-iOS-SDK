//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation
import Alamofire

typealias CommentFetchResultHandler = ((CommentFetchResult) -> Void)
typealias CommentPostResultHandler = ((PostCommentResponse) -> Void)

enum CommentsServiceError: Error {
    case failedToFetch(message: String)
    case failedToLike(message: String)
    case failedToUnLike(message: String)
    
    var message: String {
        switch self {
        case .failedToFetch(let message),
             .failedToLike(let message),
             .failedToUnLike(let message):
            return message
        }
    }
}

protocol CommentServiceProtocol {
    func fetchComments(topicHandle: String, cursor: String?, limit: Int32?, resultHandler: @escaping CommentFetchResultHandler)
    func postComment(topicHandle: String, request: PostCommentRequest, photo: Photo?, resultHandler: @escaping CommentPostResultHandler, failure: @escaping Failure)
}

class CommentsService: CommentServiceProtocol {
    
    private var cache: Cachable!
    
    // MARK: Public
    init(cache: Cachable) {
        self.cache = cache
    }
    
    func fetchComments(topicHandle: String, cursor: String? = nil, limit: Int32? = nil, resultHandler: @escaping CommentFetchResultHandler) {
        CommentsAPI.topicCommentsGetTopicComments(topicHandle: topicHandle, authorization: (SocialPlus.shared.sessionStore.user.credentials?.authHeader.values.first)!, cursor: cursor, limit: limit) { (response, error) in
            
            var result = CommentFetchResult()
            
            guard error == nil else {
                result.error = CommentsServiceError.failedToFetch(message: error!.localizedDescription)
                resultHandler(result)
                return
            }
            
            guard let data = response?.data else {
                result.error = CommentsServiceError.failedToFetch(message: "No Items Received")
                resultHandler(result)
                return
            }
            
            result.comments = self.convert(data: data)
            result.cursor = response?.cursor
            
            resultHandler(result)
        }
    }
    
    
    private var success: CommentPostResultHandler?
    private var failure: Failure?
    
    func postComment(topicHandle: String, request: PostCommentRequest, photo: Photo?, resultHandler: @escaping CommentPostResultHandler, failure: @escaping Failure) {
        self.success = resultHandler
        self.failure = failure
        
        guard let network = NetworkReachabilityManager() else {
            return
        }
        
        if network.isReachable {
            guard let image = photo?.image else {
                sendPostCommentRequest(topicHandle: topicHandle, request: request)
                return
            }
            
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {
                return
            }
            
            ImagesAPI.imagesPostImage(imageType: ImagesAPI.ImageType_imagesPostImage.contentBlob, authorization: (SocialPlus.shared.sessionStore.user.credentials?.authHeader.values.first)!,
                                      image: imageData, imageFileType: Constants.ImageUpload.type) { [weak self] (response, error) in
                                        guard let blobHandle = response?.blobHandle else {
                                            if let unwrappedError = error {
                                                failure(unwrappedError)
                                            }
                                            return
                                        }
                                        
                                        request.blobType = .image
                                        request.blobHandle = blobHandle
                                        self?.sendPostCommentRequest(topicHandle: topicHandle, request: request)
            }
            
        } else {
            if photo != nil {
                cache?.cacheOutgoing(object: photo!)
                request.blobHandle = photo?.url
            }
            
            cache?.cacheOutgoing(object: request)
        }
    }
    
    private func sendPostCommentRequest(topicHandle: String, request: PostCommentRequest) {
        CommentsAPI.topicCommentsPostComment(topicHandle: topicHandle, request: request, authorization: (SocialPlus.shared.sessionStore.user.credentials?.authHeader.values.first)!) { (response, error) in
            guard response != nil else {
                self.failure!(error!)
                return
            }
            
            self.success!(response!)
        }
    }
    
    private func convert(data: [CommentView]) -> [Comment] {
        var comments = [Comment]()
        for commentView in data {
            let comment = Comment()
            comment.commentHandle = commentView.commentHandle
            comment.firstName = commentView.user?.firstName
            comment.lastName = commentView.user?.lastName
            comment.photoUrl = commentView.user?.photoUrl
            comment.userHandle = commentView.user?.userHandle
            comment.createdTime = commentView.createdTime
            comment.text = commentView.text
            comment.liked = commentView.liked!
            comment.mediaUrl = commentView.blobUrl
            comment.topicHandle = commentView.topicHandle
            comment.totalLikes = commentView.totalLikes!
            comment.totalReplies = commentView.totalReplies!
            comments.append(comment)
        }
        return comments
        
    }
}

struct CommentFetchResult {
    var comments = [Comment]()
    var error: CommentsServiceError?
    var cursor: String?
}

class Comment: Equatable {
    public var commentHandle: String?
    public var topicHandle: String!
    public var createdTime: Date?
    
    public var userHandle: String?
    public var firstName: String?
    public var lastName: String?
    public var photoHandle: String?
    public var photoUrl: String?
    
    public var text: String?
    public var mediaUrl: String?
    public var totalLikes: Int64 = 0
    public var totalReplies: Int64 = 0
    public var liked = false
    public var pinned = false
    
    static func ==(left: Comment, right: Comment) -> Bool{
        return left.commentHandle == right.commentHandle
    }
}
