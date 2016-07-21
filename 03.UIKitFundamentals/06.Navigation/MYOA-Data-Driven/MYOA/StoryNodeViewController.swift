//
//  StoryNodeViewController.swift
//  MYOA
//
//  Created by Jarrod Parkes on 11/2/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit

class StoryNodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storyNode: StoryNode!
    
    @IBOutlet weak var adventureImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restartButton: UIButton!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set the image
        if let imageName = storyNode.imageName {
            self.adventureImageView.image = UIImage(named: imageName)
        }
        
        // Set the message text
        self.messageTextView.text = storyNode.message
        
        // Hide the restart button if there are choices to be made
        restartButton.hidden = storyNode.promptCount() > 0
    }
    
    // MARK: - Table - Place Holder Implementation
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextNode = storyNode.storyNodeForIndex(indexPath.row)
        let storyNodeViewContoller = self.storyboard!.instantiateViewControllerWithIdentifier("StoryNodeViewController")
            as! StoryNodeViewController
        storyNodeViewContoller.storyNode = nextNode
        
        self.navigationController!.pushViewController(storyNodeViewContoller, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of prompts in the storyNode
        return storyNode.promptCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: Dequeue a cell and populate it with text from the correct prompt.
        let cell = tableView.dequeueReusableCellWithIdentifier("PromptCell")! as UITableViewCell
        cell.textLabel!.text = storyNode.promptForIndex(indexPath.row)
        return cell
    }

    
    // MARK: - Actions
    
    @IBAction func restartStory() {
        let controller = self.navigationController!.viewControllers[1] 
        self.navigationController?.popToViewController(controller, animated: true)
    }
    
}