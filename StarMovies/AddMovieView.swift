//
//  ListView.swift
//  StarMovies
//
//  Created by USER on 25/02/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddMovieView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var releaseDate: String = ""
    @State private var duration: Int = 0
    @State private var rating: Int = 0
    @State private var description: String = ""
    @State private var newImage: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var movieImage: UIImage?
    @State private var date = Date()
   
    var body: some View {
        
        NavigationStack{
            
            Form {
                Section("Capa do filme"){
                    photoPicker
                }
                Section("Titulo do filme"){
                    TextField("Digite o titulo...", text: $title)
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
                    TextField("Digite a duração do filme...", value: $duration, format: .number)
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
            
            
            .navigationTitle(Text("Adicionar filme"))
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
                    Button("Add", systemImage: "checkmark") {
                        movieImage = imageData.flatMap {
                            UIImage(data: $0)
                        }
                        releaseDate = date.formatted(date: .numeric, time: .omitted)
                        let newMovie = Movie(title: title,
                                             movieDescription: description,
                                             duration: duration,
                                             releaseDate:  releaseDate,
                                             imageData: imageData,
                                             rating: rating,
                                             date: date
                        )
                        modelContext.insert(newMovie)
                        dismiss()
                    }
                    .tint(Color(.purple))
                    .disabled(imageData == nil)
                }
            }
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
}

#Preview {
    AddMovieView()
}
