//
//  ViewController.swift
//  AppNoticias
//
//  Created by alumno on 19/11/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Tabla de noticias
    
    private let vista_tabla_noticias: UITableView = {
        let tabla = UITableView()
        tabla.register(NoticiasTableViewCell.self, forCellReuseIdentifier: NoticiasTableViewCell.identificador)
        return tabla
    }()

    private var articulos = [Article]()
    private var viewModels = [NoticiasTableViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Noticias hoy"
        view.addSubview(vista_tabla_noticias)
        vista_tabla_noticias.delegate = self
        vista_tabla_noticias.dataSource = self
        view.backgroundColor = .systemBackground
        
        APINoticias.compartido.Noticias_Top { [weak self] result in
            switch result {
            case .success(let articulos):
                self?.articulos = articulos
                self?.viewModels = articulos.compactMap({NoticiasTableViewModel(
                        title: $0.title ?? "Sin titulo",
                        subtitle: $0.description ?? "Sin descripción",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.vista_tabla_noticias.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vista_tabla_noticias.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(
            withIdentifier: NoticiasTableViewCell.identificador,
            for: indexPath
        ) as? NoticiasTableViewCell else {
            fatalError()
        }
        celda.configuracion_viewModel(with: viewModels[indexPath.row])
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articulo = articulos[indexPath.row]
        
        guard let url = URL(string: articulo.url ?? "") else{
            return
        }
        
        let abrir_safari = SFSafariViewController(url: url)
        present(abrir_safari, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

