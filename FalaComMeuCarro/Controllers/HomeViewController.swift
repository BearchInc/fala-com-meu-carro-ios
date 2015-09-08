import UIKit
import SwiftEventBus

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var refreshControl: UIRefreshControl!
	
	@IBOutlet weak var postsTableView: UITableView! {
		didSet {
			self.refreshControl = UIRefreshControl()
			self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
			self.postsTableView.estimatedRowHeight = 100
			self.postsTableView.rowHeight = UITableViewAutomaticDimension
			self.postsTableView.addSubview(self.refreshControl)
		}
	}
	
	var posts = [Post]()
	var plate = ""

	deinit {
		SwiftEventBus.unregister(self)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchPosts()
		setupEvents()
	}
	
	func setupEvents() {
		SwiftEventBus.onMainThread(self, name: "postCreated", handler: appendPostHandler)
	}
	
	func isInitialController() -> Bool {
		return plate.isEmpty
	}
	
	func isControllerFromSamePlate(post: Post) -> Bool {
		return plate == post.carPlate
	}
	
	func appendPostHandler(notification: NSNotification!) {
		let post = notification.object as! Post
		
		if !isControllerFromSamePlate(post) && !isInitialController() {
			return
		}
		
		posts.insert(post, atIndex: 0)
		
		postsTableView.beginUpdates()
		postsTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
		postsTableView.endUpdates()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		postsTableView.reloadData()
	}
	
	func refresh() {
		fetchPosts()
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let postCell = tableView.dequeueReusableCellWithIdentifier("POST_CELL") as! PostCell
		postCell.render(posts[indexPath.row])
		postCell.plateButtonCallback = plateButtonCallback
		return postCell
	}
	
	private func plateButtonCallback(plate: String) {
		if title != plate {
			let viewController = Storyboards.Cars.instantiateHomeViewController()
			viewController.plate = plate
			viewController.title = plate
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
	
	private func fetchPosts() {
		plate.isEmpty ? Post.getAllPosts(displayPosts) : Post.getAllPostsByCarPlate(plate, callback: displayPosts)
	}
	
	private func displayPosts(posts: [Post]) {
		self.posts = posts
		postsTableView.reloadData()
		refreshControl.endRefreshing()
	}

	@IBAction func goToPlate(sender: AnyObject) {
		let builder = GoToPlateViewController(sentCallback: plateButtonCallback)
		presentViewController(builder.alert, animated: true, completion: nil)
	}
}

