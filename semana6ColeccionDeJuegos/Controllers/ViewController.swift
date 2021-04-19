//
//  ViewController.swift
//  semana6ColeccionDeJuegos
//
//  Created by FernandoValdivia on 4/15/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var cheemss : [Cheems] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try cheemss = context.fetch(Cheems.fetchRequest())
            tableView.reloadData()
        }
        catch{
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cheemss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cheems = cheemss[indexPath.row]
        cell.textLabel?.text = cheems.titulo
        cell.imageView?.image = UIImage(data: (cheems.imagen!) as! Data)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cheems = cheemss[indexPath.row]
        performSegue(withIdentifier: "cheemsSegue", sender: cheems)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! CreateOrUpdateGameViewController
        nextVC.cheems = sender as? Cheems
    }
}

