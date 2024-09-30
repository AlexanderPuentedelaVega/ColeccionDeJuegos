//
//  ViewController.swift
//  PuentedelaVegaColeccionDeJuegos3
//
//  Created by Alexander Puente de la Vega on 30/09/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            // Obtener el juego correspondiente a la fila actual
            let juego = juegos[indexPath.row]
            
            // Configurar el título y la imagen de la celda
            cell.textLabel?.text = juego.titulo
            if let imagenData = juego.imagen {
                cell.imageView?.image = UIImage(data: imagenData)
            }
            
            return cell

    }
    

    @IBOutlet weak var tableView: UITableView!
    var juegos : [Juego] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)  // Asegúrate de llamar al método de la superclase
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            // Obtener los datos de Core Data
            juegos = try context.fetch(Juego.fetchRequest())
            
            // Recargar la tabla con los nuevos datos
            tableView.reloadData()
            
        } catch {
            // Manejar cualquier error que ocurra durante la operación de fetch
            print("Error al cargar los juegos desde Core Data")
        }
    }


}

