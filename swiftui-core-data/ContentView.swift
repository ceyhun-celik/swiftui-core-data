//
//  ContentView.swift
//  swiftui-core-data
//
//  Created by Ceyhun Çelik on 12.02.2023.
//

import SwiftUI

struct ContentView: View {
    let coreDataManager: CoreDataManager
    
    @State private var movieTitle: String = ""
    
    /**
     * not a good idea to use state to populate data from third party call
     */
    @State private var movies: [Movie] = [Movie]()
    
    @State private var needsRefresh: Bool = false
    
    private func populateMovies() {
        movies = coreDataManager.getMovies()
    }
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                TextField("Enter Title", text: $movieTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    coreDataManager.saveMovie(title: movieTitle)
                    populateMovies()
                }
                
                List(content: {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(destination: DetailView(movie: movie, coreDataManager: coreDataManager, needsRefresh: $needsRefresh), label: {
                            Text(movie.title ?? "")
                        })
                    }.onDelete(perform: { IndexSet in
                        IndexSet.forEach({ index in
                            let movie = movies[index]
                            coreDataManager.deleteMovie(movie: movie)
                        })
                    })
                })
                .listStyle(PlainListStyle())
                .accentColor(needsRefresh ? .white : .black)
                
                Spacer()
            })
            .padding()
            .navigationTitle("Movies")
            
            .onAppear(perform: {
                populateMovies()
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDataManager: CoreDataManager())
    }
}
