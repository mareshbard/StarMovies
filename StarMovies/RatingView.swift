//
//  RatingView.swift
//  StarMovies
//
//  Created by USER on 04/03/26.
//

import SwiftUI


struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maxRating: Int = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    var body: some View {
        HStack(alignment: .center) {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self){  number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                }
                .foregroundStyle(number > rating ? offColor : onColor)
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
    
}

#Preview {
    
}
