
import UIKit
import Parse

class HSTipoServicoViewController: UIViewController
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
}

extension HSTipoServicoViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
}

extension HSTipoServicoViewController: UITableViewDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let query = data[indexPath.row]
        
        cell!.textLabel!.text = query.objectForKey("categoria") as? String
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        HSNovoServicoViewController.categoria =  (cell?.textLabel?.text)!
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}