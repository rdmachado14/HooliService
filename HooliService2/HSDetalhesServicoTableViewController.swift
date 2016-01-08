
import UIKit

class HSDetalhesServicoTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var lbTitulo: UILabel!
    
    @IBOutlet weak var lbDescricao: UILabel!
    
    @IBOutlet weak var lbCategoria: UILabel!
    
    var imagens = [
        UIImage(named: "serv"),
        UIImage(named: "serv"),
        UIImage(named: "serv"),
        UIImage(named: "serv"),
        UIImage(named: "serv"),
        UIImage(named: "serv")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool)
    {
        lbTitulo.text = "Contrução de muro"
        lbDescricao.text = "Contrução de muro de 50m de comprimento por 2,5 de altura"
        lbCategoria.text = "Alvenaria"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FotosServicoCell", forIndexPath: indexPath) as! HSFotosServicoCollectionViewCell
        
        if let image = imagens[indexPath.row]
        {
            cell.foto.image = image
        }
        
        return cell
    }
    

}
