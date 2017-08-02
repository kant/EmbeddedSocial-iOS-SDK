//
//  PostDetailPostDetailViewController.swift
//  EmbeddedSocial-Framework
//
//  Created by generamba setup on 31/07/2017.
//  Copyright © 2017 akvelon. All rights reserved.
//

import UIKit

//enum PostDetailSections: Int {
//    case comments = 0
//    case commentView
//    case sectionsCount
//}

class PostDetailViewController: BaseViewController, PostDetailViewInput {

    var output: PostDetailViewOutput!

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
        tableView.register(UINib(nibName: CommentCell.identifier, bundle: Bundle(for: CommentCell.self)), forCellReuseIdentifier: CommentCell.identifier)
        tableView.register(UINib(nibName: CommentInputCell.identifier, bundle: Bundle(for: CommentInputCell.self)), forCellReuseIdentifier: CommentInputCell.identifier)
        tableView.estimatedRowHeight = CommentCell.defaultHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    @IBAction func postComment(_ sender: Any) {
    }
}

extension PostDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == PostDetailSections.comments.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
            cell.config(comment: output.commentForPath(path: indexPath))
            cell.delegate = self
            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: CommentInputCell.identifier, for: indexPath) as! CommentInputCell
//            cell.config(tableView: tableView)
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case PostDetailSections.comments.rawValue:
            return output.numberOfItems()
//        case PostDetailSections.commentView.rawValue:
//            return 1
//        default:
//            return 0
//        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return PostDetailSections.sectionsCount.rawValue
//    }
}



extension PostDetailViewController: UITableViewDelegate {
    
}

extension PostDetailViewController: CommentCellDelegate {
    func like(cell: CommentCell) {
        //        let comment = output.commentForPath(path: tableView.indexPath(for: cell)!)
        //        if comment.liked {
        //
        //        } else {
        //
        //        }
    }
    
    func toReplies() {
        
    }
    
    func mediaLoaded() {
        tableView.reloadData()
    }
    
}
