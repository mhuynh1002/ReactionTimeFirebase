//
//  TableViewController.swift
//  ReactionTime
//
//  Created by Robert D. Brown on 7/26/17.
//  Copyright © 2017 Robert D. Brown. All rights reserved.
//

import UIKit
import CloudKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayOf = ArrayOf()
    var name: String!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            self.getScores()
        })
        
        getScores()
    }
    
    public func getScores()
    {
        arrayOf.scores = []
        arrayOf.names = []
        
        //Code Here to Connect to Firebase and get scores
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(arrayOf.names[indexPath.row])"
        cell.detailTextLabel?.text = "\(arrayOf.scores[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOf.scores.count
    }
    
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        getScores()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! ViewController
        nvc.passedArrayOf = arrayOf
        nvc.name = name
    }
    
}
