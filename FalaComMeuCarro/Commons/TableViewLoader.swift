import Foundation

class TableViewLoader {
	
	var loadingView: UIActivityIndicatorView!
	
	var tableViewParent: UIView
	var tableView: UITableView
	var emptyMessageView: UIView
	
	init(tableView: UITableView, emptyMessageView: UIView, showLoading: Bool = true) {
		self.tableView = tableView
		self.tableViewParent = tableView.superview!
		self.emptyMessageView = emptyMessageView
		
		if showLoading {
			setupLoadingView()
		}
		reloadTableView()
		showEmptyMessageLabel(false)
	}
	
	func loadFinished(_ tableIsEmpty: Bool = true) {
		stopLoading()
		showEmptyMessageLabel(tableIsEmpty)
		reloadTableView()
	}
	
	func redisplay() {
		loadingView.frame = getLoadingViewFrame()
	}
	
	private func reloadTableView() {
		tableView.reloadData()
	}
	
	private func getLoadingViewFrame() -> CGRect {
		let parentBounds = tableViewParent.bounds
		let dimensions:CGFloat = 100
		let xPosition = (CGRectGetWidth(parentBounds) - dimensions)/2
		let yPosition = (CGRectGetHeight(parentBounds) - dimensions)/2
		
		return CGRectMake(xPosition, yPosition, dimensions, dimensions)
	}
	
	private func setupLoadingView() {
		loadingView = UIActivityIndicatorView(frame: getLoadingViewFrame())
		tableViewParent.addSubview(loadingView!)
		loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
		loadingView.hidesWhenStopped = true
		loadingView.startAnimating()
	}
	
	private func stopLoading() {
		loadingView.stopAnimating()
	}
	
	private func showEmptyMessageLabel(show: Bool) {
		emptyMessageView.hidden = !show
	}
	
}
