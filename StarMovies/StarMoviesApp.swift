//
//  StarMoviesApp.swift
//  StarMovies
//
//  Created by USER on 23/02/26.
//

import SwiftUI
import SwiftData

@main
struct StarMoviesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self])
    }
}
