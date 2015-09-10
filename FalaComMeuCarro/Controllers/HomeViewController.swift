import UIKit
import SwiftEventBus

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var blankStateView: UILabel!
	@IBOutlet weak var postsTableView: UITableView! {
		didSet {
			self.refreshControl = UIRefreshControl()
			self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
			self.postsTableView.estimatedRowHeight = 120
			self.postsTableView.rowHeight = UITableViewAutomaticDimension
			self.postsTableView.addSubview(self.refreshControl)
		}
	}

	var refreshControl: UIRefreshControl!
	var tableViewLoader: TableViewLoader!
	
	var posts = [Post]()
	var plate = ""

	deinit {
		SwiftEventBus.unregister(self)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchPosts()
		setupEvents()
		setupTableViewLoader()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		tableViewLoader.redisplay()
	}
	
	private func setupTableViewLoader() {
		tableViewLoader = TableViewLoader(tableView: postsTableView, emptyMessageView: blankStateView)
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
        postCell.optionsCallback = flagPost
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
		refreshControl.endRefreshing()
		tableViewLoader.loadFinished(posts.count == 0)
	}
    
    private func flagPost(post: Post!) {
        let postAction = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        postAction.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
        postAction.addAction(UIAlertAction(title: "Impróprio/Spam", style: UIAlertActionStyle.Destructive, handler: { alertAction in
            Post.flagPost(post) { response in
                let conrimationAction = UIAlertController(title: "Post reportado!", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                conrimationAction.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(conrimationAction, animated: true, completion: nil)
            }
        }))
        
        presentViewController(postAction, animated: true, completion: nil)
    }

	@IBAction func goToPlate(sender: AnyObject) {
		let builder = GoToPlateViewController(sentCallback: plateButtonCallback)
		presentViewController(builder.alert, animated: true, completion: nil)
	}
}

