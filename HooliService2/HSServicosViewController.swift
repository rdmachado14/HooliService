//
//  HSServicosViewController.swift
//  HooliService2
//
//  Created by Rodrigo Machado on 1/7/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class HSServicosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    var object: PFObject!
    var resultadoServico = [PFObject]()
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    var titulo = String()
    
    // filtrar resultados da busca
    var searchResults = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    // table view methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        //        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell")
        
        cell.textLabel?.text = searchResults[indexPath.row]
        
        //        myCell!.textLabel?.text = searchResults[indexPath.row]
        
        //        return myCell!
        
        return cell
        
    }
    
    // search bar methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        mySearchBar.resignFirstResponder()
        
        // variáveis para percorrerem as colunas da tabela "Test"
        let firstNameTest = PFQuery(className: "Servicos")
        firstNameTest.whereKey("categoria", containsString: searchBar.text)
        
        
        
        let query = PFQuery.orQueryWithSubqueries([firstNameTest])
        
        
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error != nil || objects == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
            }
            
            if error != nil{
                
                print("Não fez o request")
                
            }else if objects == nil{
                
                print("Não retornou nada")
                
            }else{
                
                self.searchResults.removeAll(keepCapacity: false)
                
                // busca dos objetos no banco
                for object in objects!
                {
                    let firstName = object.objectForKey("categoria") as! String
//                    let lastName = object.objectForKey("sobrenome") as! String
                    let fullName = firstName + " "
                    
                    
                    self.searchResults.append(fullName)
                    
                    self.myTableView.reloadData()
                    
                    print(self.searchResults.count)
                }
                
                
            }
        }
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        
    }

    



}
