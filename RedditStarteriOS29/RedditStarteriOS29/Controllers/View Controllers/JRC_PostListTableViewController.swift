//
//  JRC_PostListTableViewController.swift
//  RedditStarteriOS29
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

import UIKit

class JRC_PostListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JRC_PostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Post was empty.")
            }
        }
        
        self.tableView.rowHeight = 136.5
        self.tableView.estimatedRowHeight = 136.5
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JRC_PostController.shared().posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? JRC_PostTableViewCell else {return UITableViewCell()}
        
        let post = JRC_PostController.shared().posts[indexPath.row]
        cell.titleLabel.text = post.title
        
        JRC_PostController.shared().fetchImage(post) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        return cell
    }
}
