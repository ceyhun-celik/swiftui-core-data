//
//  DetailView.swift
//  swiftui-core-data
//
//  Created by Ceyhun Çelik on 12.02.2023.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    @State private var movieTitle: String = ""
    
    let coreDataManager: CoreDataManager
    
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Update") {
                if !movieTitle.isEmpty {
                    movie.title = movieTitle
                    coreDataManager.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie()
        let coreDataManager = CoreDataManager()
        
        DetailView(movie: movie, coreDataManager: coreDataManager, needsRefresh: .constant(false))
    }
}
