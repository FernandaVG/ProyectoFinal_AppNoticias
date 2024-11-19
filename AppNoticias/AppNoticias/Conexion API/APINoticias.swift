//
//  APINoticias.swift
//  AppNoticias
//
//  Created by alumno on 19/11/24.
//

import Foundation

final class APINoticias{
    
    private var articulos: [Article] = []
    private var api_respuesta: APIRespuesta? = nil
    
    static let compartido = APINoticias()
    
    struct ApiURL {
        static let noticias_URL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2024-10-19&sortBy=publishedAt&apiKey=518a3a8903454cdc9d14cfb644047200")
    }
    
    private init() {}
    
    public func Noticias_Top(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = ApiURL.noticias_URL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data{
                do{
                    let resultado = try JSONDecoder().decode(APIRespuesta.self, from: data)
                    self.articulos = resultado.articles
                    self.api_respuesta = resultado
                    print("Articulos: \(resultado.articles.count)")
                    completion(.success(resultado.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

