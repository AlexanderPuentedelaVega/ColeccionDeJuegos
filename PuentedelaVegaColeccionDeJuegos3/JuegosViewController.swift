//
//  JuegosViewController.swift
//  PuentedelaVegaColeccionDeJuegos3
//
//  Created by Alexander Puente de la Vega on 30/09/24.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var imagePicker = UIImagePickerController()
    var juego: Juego? = nil
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!

    // Definir categorías
    let categorias = ["Acción", "Aventura", "Puzzle", "Deportes", "Estrategia"]

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        categoriaPicker.delegate = self
        categoriaPicker.dataSource = self

        if juego != nil {
            imageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo

            // Seleccionar la categoría en el picker
            if let categoria = juego!.categoria {
                if let index = categorias.firstIndex(of: categoria) {
                    categoriaPicker.selectRow(index, inComponent: 0, animated: false)
                }
            }
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        } else {
            eliminarBoton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func camaraTapped(_ sender: Any) {
    }

    @IBAction func agregarTapped(_ sender: Any) {
        let categoriaSeleccionada = categorias[categoriaPicker.selectedRow(inComponent: 0)]

        if juego != nil {
            // Actualizar los valores del juego existente
            juego!.titulo = tituloTextField.text
            juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
            juego!.categoria = categoriaSeleccionada // Actualizar categoría
        } else {
            // Crear un nuevo objeto Juego en Core Data
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = categoriaSeleccionada // Asignar categoría
        }

        // Guardar el contexto
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        // Volver a la vista anterior
        navigationController?.popViewController(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UIPickerViewDataSource

    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Solo una columna para categorías
    }

    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count // Número de categorías
    }

    @objc func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row] // Mostrar el nombre de la categoría
    }

    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
