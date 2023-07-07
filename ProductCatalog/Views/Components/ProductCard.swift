//
//  ProductCard.swift
//  ProductCatalog
//
//  Created by Indra Permana on 06/07/23.
//

import SwiftUI

struct ProductCard: View {
    
    @Binding var model: HomeProductModel
    let width: Double
    var isFavorite: Bool
    let onFavoriteTapped: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: model.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .accessibility(hidden: false)
                        .accessibilityLabel(Text(model.title))
                        .frame(height: 150)
                }  else if phase.error != nil  {
                    VStack {
                        Image(uiImage: .checkmark)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: width / 2)
                        Text("Please try again.")
                            .font(.title3)
                    }
                    
                } else {
                    ProgressView()
                        .frame(height: 150)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: model.isFavorite ? "heart.fill" : "heart")
                    .onTapGesture {
                        onFavoriteTapped()
                        model.isFavorite.toggle()
                    }
                Text(model.title)
                    .font(.subheadline)
                    .lineLimit(3)
                
                Text("$ " + (model.price.description))
                    .font(.title2.bold())
                
                HStack(alignment: .bottom) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .frame(width: 20, height: 20)
                    Text(model.rating.description)
                        .font(.footnote)
                    Spacer()
                }
            }
            .padding()
            
        }
        .frame(width: width, height: 350)
        .cardBackground()
        .onAppear {
            self.model.isFavorite = isFavorite
        }
        
    }
}

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("cardBg"))
            .cornerRadius(10)
            .shadow(radius: 4)
    }
}

extension View {
    func cardBackground() -> some View {
        modifier(CardBackground())
    }
}

//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCard()
//    }
//}
