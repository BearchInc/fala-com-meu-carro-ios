import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var postsTableView: UITableView!
	
	var posts = [Post]()

	override func viewDidLoad() {
		super.viewDidLoad()
		Post.getAllPosts { (posts) in
			self.posts = posts
			self.postsTableView.reloadData()
		}
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let postCell = tableView.dequeueReusableCellWithIdentifier("POST_CELL") as! PostCell
		postCell.render(posts[indexPath.row])
		return postCell
	}
}

