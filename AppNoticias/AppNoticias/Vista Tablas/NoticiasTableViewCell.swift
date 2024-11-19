//
//  NoticiasTableViewCell.swift
//  AppNoticias
//
//  Created by alumno on 19/11/24.
//

import UIKit

class NoticiasTableViewCell: UITableViewCell {
    
    static let identificador = "NoticiasTableViewCell"
    
    
    //Estilo textos
    private let titulo_noticias: UILabel = {
        let titulo = UILabel()
        titulo.numberOfLines = 0
        titulo.font = .systemFont(ofSize: 22, weight: .semibold)
        return titulo
    }()
    
    private let subtitulo_noticias: UILabel = {
        let subtitulo = UILabel()
        subtitulo.numberOfLines = 0
        subtitulo.font = .systemFont(ofSize: 12, weight: .light)
        return subtitulo
    }()
    
    private let imagen: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titulo_noticias)
        contentView.addSubview(subtitulo_noticias)
        contentView.addSubview(imagen)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titulo_noticias.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 180, height: contentView.frame.size.height/2)
        
        subtitulo_noticias.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 230, height: contentView.frame.size.height/2)
        
        imagen.frame = CGRect(x: contentView.frame.size.width-150, y: 5, width: 160, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titulo_noticias.text = nil
        subtitulo_noticias.text = nil
        imagen.image = nil
    }
    
    func configuracion_viewModel(with viewmodel: NoticiasTableViewModel) {
        titulo_noticias.text = viewmodel.title
        subtitulo_noticias.text = viewmodel.subtitle
        
        //Imagen
        if let data = viewmodel.imageData {
            imagen.image = UIImage(data: data)
        }
        else if let url = viewmodel.imageURL{
            //fetch
            
            URLSession.shared.dataTask(with: url) {
                data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewmodel.imageData = data
                DispatchQueue.main.async {
                    self.imagen.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
