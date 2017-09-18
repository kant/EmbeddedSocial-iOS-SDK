//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class LikeReplyOperation: ReplyCommandOperation {
    
    override func main() {
        guard !isCancelled else {
            return
        }
        
        likesService.likeReply(replyHandle: command.replyHandle) { [weak self] _, _ in
            guard let strongSelf = self, !strongSelf.isCancelled else {
                return
            }
            strongSelf.completeOperation()
        }
    }
}