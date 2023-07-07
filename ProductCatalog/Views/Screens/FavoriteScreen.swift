//
//  FavoriteScreen.swift
//  ProductCatalog
//
//  Created by Indra Permana on 07/07/23.
//

import SwiftUI

struct FavoriteScreen: View {
    
    @FetchRequest(sortDescriptors: []) var savedProducts: FetchedResults<Product>
    @State private var favoriteSearchText = ""
    var favoriteQuery: Binding<String> {
        Binding {
            favoriteSearchText
        } set: { newValue in
            favoriteSearchText = newValue
            debugPrint(newValue)
            savedProducts.nsPredicate = newValue.isEmpty
                           ? nil
                           : NSPredicate(format: "title CONTAINS %@", newValue)
        }
    }
    
    var body: some View {
        VStack {
            if savedProducts.count == 0 {
                Spacer()
                Text("No favorite product saved")
                Spacer()
            }
            
            List(savedProducts) { product in
                HStack(alignment: .center) {
                    AsyncImage(url: URL(string: product.image ?? "")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .accessibility(hidden: false)
                                .accessibilityLabel(Text(product.title ?? ""))
                                .frame(width: 150)
                        }  else if phase.error != nil  {
                            VStack {
                                Image(uiImage: .checkmark)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 150)
                                Text("Please try again.")
                                    .font(.title3)
                            }
                            
                        } else {
                            ProgressView()
                                .frame(width: 150)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(product.title ?? "")
                            .font(.subheadline)
                            .lineLimit(3)
                        
                        Text("$ " + (product.price.description))
                            .font(.title2.bold())
                        
                        HStack(alignment: .bottom) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 20, height: 20)
                            Text(product.rating.description)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                }
                .frame(height: 150)
                .padding(.bottom, 12)
            }
            .searchable(text: favoriteQuery)
        }
    }
}
