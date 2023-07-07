# Product Catalog iOS App

See Catalog of various available products, and save to favorite.

## Features
- Fetching Product Catalogs
- Swipe down after finished fetching products to Filter / Search titles
- Save and Unsave to local data for favorites products 


## 🔧 Setting up Local Development

Required:

- [Xcode 14+](https://developer.apple.com/download) This project was compiled using Xcode 14.2.
- iOS 15 minimum deployment.

## Architecture
This project is following MVC, Model-View-Controller.


## Project Structure

```
ProductCatalog                  # Root
 -[Controllers]                 # Controller Classes
 -[Views]                       # SwiftUI screens and components views 
 -[Data]                        # API configs, CoreDataModel, Mappers
   -[Models]                    # Data Model structs from API and for views
 -[Resources]                   # Assets Resource
 -ProductCatalogApp.swift       # App entry point
```

### Built with
- **Swift 5** compiled on XCode 14.2
- **MVC** Model-View-Controller Design Pattern
- **SwiftUI** Apple latest UI Framework
- **API from: https://fakestoreapi.com/products**
