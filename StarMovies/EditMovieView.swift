//
//  ListView.swift
//  StarMovies
//
//  Created by USER on 25/02/26.
//

import SwiftUI
import PhotosUI

struct EditMovieView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State var releaseDate: String = ""
    @State private var duration: Int = 0
    @State private var rating: Int = 0
    @State private var description: String = ""
    @State private var newImage: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var movieImage: UIImage?
    var movie: Movie
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section("Capa do filme"){
                    photoPicker
                }
                Section("Titulo do filme"){
                    
                    TextField("\(movie.title)", text: $title)
                        .font(.body)
                }
                
                Section("Data de lançamento"){
                    Text("Escolha a data...")
                        .font(.body)
                    
                    DatePicker("Escolha a data",
                               selection: $date,
                               displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    
                }
                
                .font(.title3)
                .fontWeight(.bold)
                Section("Duração"){
                    TextField(String(movie.duration), value: $duration, format: .number)
                        .font(.body)
                }
                
                Section("Avaliação"){
                    RatingView(rating: $rating)
                        .buttonStyle(.plain)
                    
                }
                
                Section("Descrição"){
                    TextField("Digite a sinopse do filme...", text: $description, axis: .vertical )
                        .font(.body)
                        .lineLimit(10, reservesSpace: true)
                }
                
                
                
            }
            .font(.title3)
            .fontWeight(.bold)
            
            
            .navigationTitle(Text("Editar filme"))
            .toolbarTitleDisplayMode( .inline)
            .toolbar {
                
                ToolbarItem (placement: .cancellationAction){
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        movieImage = imageData.flatMap {
                            UIImage(data: $0)
                        }
                        releaseDate = date.formatted(date: .numeric, time: .omitted)
                        editMovie()
                        dismiss()
                    } label: {
                        Label("Salvar", systemImage: "checkmark")
                    }
                    
                }
            }
        }
        .onAppear{
            
            if let date = movie.date {
                self.date = date
            }
            title = movie.title
            releaseDate = movie.releaseDate
            rating = movie.rating
            duration = movie.duration
            description = movie.movieDescription
            
            // MARK: Equivalentes
            if let imageData = movie.imageData {
                self.imageData = imageData
            }
            //            if movie.imageData != nil {
            //                let imageData: Data = movie.imageData!
            //            }
        }
        
    }
    
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage){
            Group {
                if let imageData, let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                    
                } else{
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 400)
                        .frame(maxWidth: .infinity)
                    // .background(Color.gray.opacity(0.3))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage){
            guard let newImage else {return}
            
            Task {
                imageData = try await
                newImage.loadTransferable(type: Data.self)
            }
        }
    }
    
    func editMovie() {
        movie.title = title
        
        movie.releaseDate = releaseDate
        movie.rating = rating
        movie.duration = duration
        movie.imageData = imageData
        movie.movieDescription = description
        
    }
}
#Preview {
    EditMovieView(
        movie: Movie(
            title: "Teste",
            movieDescription: "Descrição",
            duration: 2,
            releaseDate: "05/03/2026",
            rating: 5,
            date: Date.now
        )
    )
}
