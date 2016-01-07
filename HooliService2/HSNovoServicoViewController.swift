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
    @IBOutlet weak var minhaCollectionView: UICollectionView!
    @IBOutlet weak var imagem: UIImageView!
    
    var imagens: [UIImage] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        minhaCollectionView.hidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btSalvar(sender: AnyObject)
    {
        let object = PFObject(className: "Anuncios")
        
        
        // salvando os objetos no banco
        object["titulo"] = tfTitulo.text
        object["descricao"] = tfDescricao.text
        
        var fotos: [PFFile] = []
        for i in 0..<imagens.count
        {
            let fotoData = UIImagePNGRepresentation(imagens[i])
            fotos.append(PFFile(name: "fotos", data: fotoData!)!)
            object["imagem\(i)"] = fotos[i]
        }

        
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
    
    @IBAction func btAdicionarFoto(sender: AnyObject)
    {
        let alert:UIAlertController = UIAlertController(title: "Escolha o tipo.",
            message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Câmera", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Galeria", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel) { UIAlertAction in
            
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func openCamera()
    {
        let picker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            openGallery()
        }
    }
    
    
    func openGallery()
    {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
}

extension HSNovoServicoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    internal func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("testando a foto: \(image)")
        imagens.append(image)
        minhaCollectionView.hidden = false
        minhaCollectionView.reloadData()
        
        //imageHolderButton.setImage(image, forState: .Normal)
    }
    
}

extension HSNovoServicoViewController: UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imagens.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell: HSNovoServicoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HSNovoServicoCollectionViewCell
        cell.imagem.image = imagens[indexPath.row]
        
        return cell
    }
    
    
}
