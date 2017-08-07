//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit
import SnapKit

private let headerAspectRatio: CGFloat = 2.25
private let containerInset: CGFloat = 6.0
private let filterHeight: CGFloat = 44.0
private let contentWidth = UIScreen.main.bounds.width - containerInset * 2
private let headerHeight = contentWidth / headerAspectRatio

class UserProfileViewController: UIViewController {
    
    var output: UserProfileViewOutput!
    
    @IBOutlet fileprivate weak var containerTableView: UITableView! {
        didSet {
            containerTableView.backgroundColor = .clear
            containerTableView.dataSource = self
            containerTableView.delegate = self
        }
    }
    
    @IBOutlet fileprivate weak var loadingIndicatorView: LoadingIndicatorView! {
        didSet {
            loadingIndicatorView.apply(style: .standard)
        }
    }
    
    fileprivate lazy var createPostButton: BarButtonItemWithTarget = { [unowned self] in
        let button = BarButtonItemWithTarget()
        button.image = UIImage(asset: .iconDots)
        button.onTap = {
            self.output.onMore()
        }
        return button
    }()
    
    fileprivate lazy var summaryView: ProfileSummaryView = { [unowned self] in
        let summaryView = ProfileSummaryView.fromNib()
        summaryView.onEdit = { self.output.onEdit() }
        summaryView.onFollowing = { self.output.onFollowing() }
        summaryView.onFollow = { self.output.onFollowRequest(currentStatus: $0) }
        summaryView.onFollowers = { self.output.onFollowers() }
        summaryView.frame = CGRect(x: 0.0, y: 0.0, width: contentWidth, height: headerHeight)
        return summaryView
    }()
    
    fileprivate lazy var filterView: SegmentedControlView = { [weak self] in
        let filterView = SegmentedControlView.fromNib()
        filterView.setSegments([
            SegmentedControlView.Segment(title: "Recent posts", action: { self?.output.onRecent() }),
            SegmentedControlView.Segment(title: "Popular posts", action: { self?.output.onPopular() })
            ])
        filterView.selectSegment(0)
        filterView.isSeparatorHidden = false
        filterView.separatorColor = Palette.extraLightGrey
        return filterView
    }()
    
    fileprivate var feedView: UIView!
    
    fileprivate var feedModuleInput: FeedModuleInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func setupInitialState() {
        parent?.navigationItem.rightBarButtonItem = createPostButton
        view.backgroundColor = Palette.extraLightGrey
        parent?.navigationController?.navigationBar.isTranslucent = false
        automaticallyAdjustsScrollViewInsets = false
        containerTableView.tableHeaderView = embeddedIntoContainer(view: summaryView)
        setupFeedModule()
    }
    
    fileprivate func setupFeedModule() {
        let configurator = FeedModuleConfigurator()
        configurator.configure(navigationController: self.navigationController!)
        
        feedModuleInput = configurator.moduleInput!
        
        let feedViewController = configurator.viewController!
        
        feedViewController.willMove(toParentViewController: self)
        addChildViewController(feedViewController)
        feedViewController.didMove(toParentViewController: self)
        
        feedView = feedViewController.view
        feedModuleInput.setFeed(.user(user: "3v9gnzwILTS", scope: .recent))
        
        //        // Sample for input change
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        //
        //            let feed = FeedType.single(post: "3vErWk4EMrF")
        //            self.feedModuleInput.setFeed(feed)
        //            self.feedModuleInput.refreshData()
        //        }
    }
    
    private func embeddedIntoContainer(view: UIView) -> UIView {
        var containerFrame = view.frame
        containerFrame.size.height += containerInset * 2
        
        let headerContainer = UIView(frame: containerFrame)
        headerContainer.backgroundColor = Palette.extraLightGrey
        headerContainer.addSubview(view)
        
        var viewFrame = view.frame
        viewFrame.origin.y = containerInset
        view.frame = viewFrame
        
        return headerContainer
    }
    
    func showError(_ error: Error) {
        showErrorAlert(error)
    }
    
    func setIsLoading(_ isLoading: Bool) {
        loadingIndicatorView.isHidden = !isLoading
        loadingIndicatorView.isLoading = isLoading
        containerTableView.isHidden = isLoading
    }
    
    func setUser(_ user: User) {
        summaryView.configure(user: user)
    }
    
    func setFollowStatus(_ followStatus: FollowStatus) {
        summaryView.configure(followStatus: followStatus)
    }
    
    func setIsProcessingFollowRequest(_ isLoading: Bool) {
        summaryView.isLoadingFollowStatus = isLoading
    }
    
    func setFollowersCount(_ followersCount: Int) {
        summaryView.followersCount = followersCount
    }
}

extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CellID")
//        cell.textLabel?.text = "\(indexPath.row)"
        if feedView.superview == nil {
            cell.addSubview(feedView)
            feedView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
}

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return filterView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return filterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navBarHeight: CGFloat = 64.0
        let feedHeight = UIScreen.main.bounds.height - filterHeight
        let contentHeight = headerHeight + filterHeight + feedHeight + containerInset * 2 - navBarHeight
        return contentHeight
    }
}
