//
//  HomeScreen.swift
//  ProductCatalog
//
//  Created by Indra Permana on 04/07/23.
//

import SwiftUI

struct HomeScreen<Controller>: View, Sendable where Controller: HomeController {
    @EnvironmentObject var homeController: Controller
    @Environment(\.managedObjectContext) var context
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
    private var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            TabView {
                ScrollView {
                    switch homeController.state {
                    case .idle:
                        Color.clear
                    case .loading:
                        Color.clear
                            .frame(height: 200)
                        ProgressView()
                    case .failed(let error):
                        VStack {
                            Text("Error")
                                .foregroundColor(Color.red)
                            Text(error.localizedDescription)
                                .font(.footnote)
                        }
                        .padding()
                    case .loaded:
                        LazyVGrid(columns: columns) {
                            ForEach($homeController.filteredProducts) { $product in
                                GeometryReader { geometry in
                                    let isFavorite = savedProducts.contains(where: { $0.id == Int16(product.id) })
                                    ProductCard(model: $product, width: geometry.size.width, isFavorite: isFavorite) {
                                            if !product.isFavorite {
                                                debugPrint("saving...")
                                                saveFavoriteProduct(product)
                                            } else {
                                                debugPrint("deleting...")
                                                deleteFavoriteProduct(product)
                                            }
                                        }
                                }
                            }
                            .padding(.bottom, 350)
                        }
                        .searchable(text: $homeController.searchText)
                        .onChange(of: homeController.searchText) { _ in
                            homeController.searchProducts()
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .task {
                    await homeController.fetchProducts()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            }
            .navigationTitle("Product Catalog")
            .toolbar {
                NavigationLink {
                    FavoriteScreen()
                } label: {
                    Image(systemName: "heart.fill")
                        .accessibility(hidden: false)
                        .accessibilityLabel(Text("Favorite Products"))
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func saveFavoriteProduct(_ product: HomeProductModel) {
        let localProduct = Product(context: context)
        localProduct.id = Int16(product.id)
        localProduct.title = product.title
        localProduct.image = product.image
        localProduct.price = product.price
        localProduct.category = product.category
        localProduct.productDescription = product.description
        localProduct.rating = product.rating
        
        try? context.save()
    }
    
    private func deleteFavoriteProduct(_ product: HomeProductModel) {
        if let localProduct = savedProducts.first(where: {$0.id == Int16(product.id)}) {
            context.delete(localProduct)
            
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }
    }
}
