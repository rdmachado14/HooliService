//
//  HSTipoServicoViewController.swift
//  HooliService2
//
//  Created by Rodrigo Machado on 1/8/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class HSTipoServicoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var minhaTableView: UITableView!
    var data: [PFObject]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadParse()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loadParse()
    {
        
        data = []

        let servicos = PFQuery(className: "Servicos")
        
        servicos.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in

            if error == nil
            {
                
                for object: PFObject in objects!
                {
                    
                    self.data.append(object)
                    
                }
                self.minhaTableView.reloadData()
                
            }
            else
            {
                
                print("Vazio")
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let query = data[indexPath.row]
        
        cell!.textLabel!.text = query.objectForKey("categoria") as? String
        
        return cell!

    }
}
