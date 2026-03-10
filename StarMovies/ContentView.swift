
import SwiftUI
import PhotosUI
import Playgrounds
import SwiftData

struct ContentView: View {
    @State private var showAddMovie: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Movie.title) private var movies: [Movie]

    var body: some View {
        
        NavigationStack {
            VStack {
                
                List {
                    
                    ForEach(movies) {  movie in
                        
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            
                            HStack {
                                Image(uiImage: movie.image!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 100)
                                    .padding(10)
                                
                                Text("""
                                 **Título:** \(movie.title)
                                 **Duração:** \(movie.duration)min
                                 **Lançamento:** \(movie.releaseDate)
                                 **Avaliação:** \(movie.rating) \u{2B50}
                                 """)
                                .multilineTextAlignment(.leading)
                                
                            }
                            
                        }
                        
                    }
                    
                    .onDelete{ offsets in
                        for index in offsets {
                            let movie = movies[index]
                            modelContext.delete(movie)
                        }
                    }
                   
                    
                }
              //  .scrollContentBackground(.hidden)
             //   .background(Color(.white))
                
                .navigationTitle(Text("Filmes"))
                .toolbarTitleDisplayMode( .inline)
                .toolbar {
                    ToolbarItem(placement: .principal){
                        Text("StarMovies")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    ToolbarItem (placement: .primaryAction){
                        Button {
                            showAddMovie = true
                        } label: {
                            Image(systemName: "plus")
                        }.sheet(isPresented: $showAddMovie) {
                            AddMovieView()
                        }
                        .tint(Color(.purple))
                    }
                }
            }
        }
        .tint(.pink)
        .accentColor(.purple)
        
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: [Movie.self])
      // .preferredColorScheme(ColorScheme.dark)
    
}
