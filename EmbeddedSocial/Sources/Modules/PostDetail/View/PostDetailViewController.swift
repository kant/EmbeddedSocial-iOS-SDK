//
//  PostDetailPostDetailViewController.swift
//  EmbeddedSocial-Framework
//
//  Created by generamba setup on 31/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import UIKit

class PostDetailViewController: BaseViewController, PostDetailViewInput {

    var output: PostDetailViewOutput!

    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: PostDetailViewInput
    func setupInitialState() {
        configTableView()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellReuseIdentifier: CommentCell.identifier)
    }
    
    @IBAction func postComment(_ sender: Any) {
    }
}

extension PostDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension PostDetailViewController: UITableViewDelegate {
    
}

extension PostDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        commentTextViewHeight.constant = commentTextView.contentSize.height
        view.layoutIfNeeded()
        textView.setContentOffset(CGPoint.zero, animated:false)
        postButton.isEnabled = !textView.text.isEmpty
    }
}
