//
//  MovieDetailsView.swift
//  StarMovies
//
//  Created by USER on 02/03/26.
//
import SwiftData
import SwiftUI

struct MovieDetailsView: View {
    
    @State private var showEditMovie: Bool = false
    @Environment(\.dismiss) var dismiss
    var movie: Movie
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Section("") {
                    Image(uiImage: movie.image!)
                        .resizable()
                        .scaledToFill()
                }.frame(maxWidth: 250)
                
                Text(movie.title)
                    .font(.title)
                    .bold(true)
                
                
                Section("Descrição") {
                    Text(movie.movieDescription)
                        .font(.body)
                        .bold(false)
                }.font(.title2)
                    .bold(true)
                    .padding(5)
                    .frame(
                        maxWidth: 350,
                        alignment: .leading
                    )
                
                Section("Data de lançamento") {
                    Text(movie.releaseDate)
                        .font(.body)
                        .bold(false)
                }.font(.title2)
                    .bold(true)
                    .padding(5)
                    .frame(
                        maxWidth: 350,
                        alignment: .leading)
                
                Section("Avaliação") {
                    Text("\u{2B50} \(movie.rating)")
                        .font(.body)
                        .bold(false)
                }
                .font(.title2)
                .bold(true)
                .padding(5)
                .frame(
                    maxWidth: 350,
                    alignment: .leading)
                
                Section("Duração do filme") {
                    Text("\(movie.duration)min").font(.body)
                        .bold(false)
                }.font(.title2)
                    .bold(true)
                    .padding(5)
                    .frame(
                        maxWidth: 350,
                        alignment: .leading)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .primaryAction){
                Button {
                    showEditMovie = true
                } label: {
                    Label("Editar", systemImage: "square.and.pencil")
                    // Image(systemName: "square.and.pencil")
                }.sheet(isPresented: $showEditMovie) {
                    EditMovieView(movie: movie)
                }
                .tint(Color(.purple))
            }
            
            ToolbarItem (placement: .topBarLeading){
                Button {
                    dismiss()
                } label: {
                    Label("Voltar", systemImage: "chevron.backward")
                }
                .tint(.purple)
            }
            
        }
        
        
        
    }
    
}

#Preview {
    //    @Previewable var movie = Movie(title: "SS", movieDescription: "SS", duration: 100, releaseDate: "22/10/2006", imageData: nil, rating: 5)
    //    MovieDetailsView(movie: movie)
    ContentView()
        .modelContainer(for: [Movie.self])
}
