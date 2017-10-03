//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest
@testable import EmbeddedSocial

// Test should not be included.

class FeedCellTests: XCTestCase {
    
    
    let defaultWidth = CGFloat(334)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCellHeightForSingleLine() {
        
        
        let cell: PostCell = PostCell.nib.instantiate(withOwner: self, options: nil).first as! PostCell
        
        var post = Post.mock()
        post.title = "Title"
        post.text = "1\n2\n3"
        
        let viewModel = PostViewModel(with: post, isTrimmed: true, cellType: "")
        
        cell.configure(with: viewModel, collectionView: nil)
    
        let height = cell.getHeight(with: 367)
        
        
        XCTAssertTrue(height == 205)
    }
    
    func testCellWithLongTopic() {
        
        let cell = PostCell.nib.instantiate(withOwner: self, options: nil).first as! PostCell
        
        let postData: TopicView = loadResponse(from: "longTopic")!
        
        let post = Post(data: postData)!
        let postViewModel = PostViewModel(with: post, isTrimmed: false, cellType: "")
        
        cell.configure(with: postViewModel, collectionView: nil)
        
        let v = UITextView(frame: CGRect(x: 0, y: 0, width: defaultWidth, height: 0))
        v.text = post.text
        v.sizeToFit()
        
        
        let height = cell.getHeight(with: defaultWidth)
        
        let a = 1
        
    }
    
}
