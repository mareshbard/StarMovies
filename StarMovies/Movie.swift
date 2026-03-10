//
//  Movie.swift
//  StarMovies
//
//  Created by USER on 25/02/26.
//

import SwiftUI
import PhotosUI
import SwiftData
import UIKit

@Model
class Movie {
    var id = UUID()
    var title: String
    var movieDescription: String
    var duration: Int
    var releaseDate: String
    var imageData: Data?
    var rating: Int
    var date: Date?
    
    init(id: UUID = UUID(), title: String, movieDescription: String, duration: Int, releaseDate: String, imageData: Data? = nil, rating: Int, date: Date) {
        self.id = id
        self.title = title
        self.movieDescription = movieDescription
        self.duration = duration
        self.releaseDate = releaseDate
        self.imageData = imageData
        self.rating = rating
        self.date = date
    }
    
    var image: UIImage? {
        imageData.flatMap
        {
            UIImage(data: $0)
        }
    }
}
