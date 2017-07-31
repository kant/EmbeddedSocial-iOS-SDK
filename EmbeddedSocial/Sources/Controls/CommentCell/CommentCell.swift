//
//  CommentCell.swift
//  EmbeddedSocial
//
//  Created by Mac User on 31.07.17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: class {
    func like()
    func unlike()
    func toReplies()
}

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var repliesCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postedTimeLabel: UILabel!
    
    var delegate: CommentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "CommentCell"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(comment: CommentView) {
        imageView?.setPhotoWithCaching(Photo(uid: UUID().uuidString,
                                             url: comment.user?.photoUrl,
                                             image: nil),
                                       placeholder: UIImage(asset: .userPhotoPlaceholder))
        
        repliesCountLabel.text = "\(comment.totalReplies ?? 0) likes"
        likesCountLabel.text = "\(comment.totalLikes ?? 0) comments"
        commentTextLabel.text = comment.text
        usernameLabel.text = "\(comment.user?.firstName ?? "") + \(comment.user?.lastName ?? "")"
        
    }
    
    @IBAction func likePressed(_ sender: Any) {
    }

    @IBAction func commentPressed(_ sender: Any) {
    }
    
}
