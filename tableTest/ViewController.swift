//
//  ViewController.swift
//  tableTest
//
//  Created by Chris McGrath on 4/22/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

import UIKit
import QuartzCore

class customCell: UITableViewCell{
    @IBOutlet var sampleView: UIView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var info1Label: UILabel!
    @IBOutlet weak var info2Label: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    func useNode (node:Node){
        sampleView.layer.cornerRadius = 10
        sampleView.layer.masksToBounds = true
        
        titleLabel.text = node.title
        
        picture.image = UIImage(named: node.imageName!)
        
        if (node.age != nil){
            var prefix = "Age: "
            info1Label.text = prefix + node.age!
        }else if (node.job != nil ){
            info1Label.text = node.job
        }else{
            info1Label.text = node.major
        }
        
        if (node.GPA != nil){
            info2Label.text = node.GPA
        }else{
            info2Label.text = node.date
        }
        
        locationLabel.text = node.location
        aboutLabel.text = node.about
        
    }
}

class TipInCellAnimator {
    // placeholder for things to come -- only fades in for now
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        let rotationDegrees: CGFloat = -25
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
        let offset = CGPointMake(0, -20)
        var startTransform = CATransform3DIdentity
        startTransform = CATransform3DRotate(CATransform3DIdentity, rotationRadians, 0.0, 0.0, 1.0)
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
        
        view.layer.transform = startTransform
        view.layer.opacity = 0.5
        
        UIView.animateWithDuration(0.8) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 0.8
        }
    }
}

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate{

    var toDoItems: [Node] = []
    
    func loadData(){
        let path = NSBundle.mainBundle().pathForResource("resume", ofType: "json")
        toDoItems = Node.loadMembersFromFile(path!)
        self.tableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .None
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0

        loadData();
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! customCell
            cell.backgroundColor = UIColor.clearColor()
            let item = toDoItems[indexPath.row]
        
        
            cell.useNode(item)
        
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
        
            return cell
    }

    // MARK: - Table view delegate
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count
        let val = (CGFloat(index) / CGFloat (itemCount)) * 0.6
        var newColor = UIColor(red: 0.25, green: 0.0, blue: val, alpha: 1.0)
        return newColor

    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            TipInCellAnimator.animate(cell)
            cell.backgroundColor = colorForIndex(indexPath.row)

    }
}

