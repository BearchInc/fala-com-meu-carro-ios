import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var postsTableView: UITableView!
	
	var posts = [Post]()
	var plate = ""

	override func viewDidLoad() {
		super.viewDidLoad()
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
	}

	@IBAction func goToPlate(sender: AnyObject) {
		let builder = GoToPlateViewController(sentCallback: plateButtonCallback)
		presentViewController(builder.alert, animated: true, completion: nil)
	}
}

