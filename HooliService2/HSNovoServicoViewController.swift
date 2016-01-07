//
//  HSNovoServicoViewController.swift
//  HooliService2
//
//  Created by Rodrigo Machado on 1/7/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class HSNovoServicoViewController: UIViewController
{

    @IBOutlet weak var tfTitulo: UITextField!
    @IBOutlet weak var tfDescricao: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func btSalvar(sender: AnyObject)
    {
        let object = PFObject(className: "Anuncios")
        
        object["titulo"] = tfTitulo.text
        object["descricao"] = tfDescricao.text
        
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if success
            {
                print("objeto salvo!")
            }
            else
            {
                print(error)
            }
        }
    }
 

}
