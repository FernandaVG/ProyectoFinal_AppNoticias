//
//  NoticiasTableViewModel.swift
//  AppNoticias
//
//  Created by alumno on 19/11/24.
//

import Foundation

class NoticiasTableViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
