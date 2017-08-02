//
//  CommentInputCell.swift
//  EmbeddedSocial
//
//  Created by Mac User on 02.08.17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import UIKit

class CommentInputCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var mediaImageViewHeightConstraint: NSLayoutConstraint!
    
    static let identifier = "CommentInputCell"
    
    weak var tableView: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.delegate = self
        // Initialization code
    }
    
    func config(tableView: UITableView) {
        self.tableView = tableView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CommentInputCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView?.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView?.setContentOffset(currentOffset!, animated: false)
    }
}
