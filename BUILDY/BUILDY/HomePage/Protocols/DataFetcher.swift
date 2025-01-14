//
//  DataFetcher.swift
//  BUILDY
//
//  Created by Nino Kurshavishvili on 14.01.25.
//


protocol DataFetcher {  
    func fetchCategories()
    func fetchProducts()
}  

class HomePageDataFetcher: DataFetcher {  
    private let categoriesViewModel: CategoriesViewModel  
    private let viewModel: HomePageViewModel  

    init(categoriesViewModel: CategoriesViewModel, viewModel: HomePageViewModel) {  
        self.categoriesViewModel = categoriesViewModel  
        self.viewModel = viewModel  
    }  

    func fetchCategories() {  
        categoriesViewModel.fetchCategories()  
    }  

    func fetchProducts() {  
        viewModel.fetchProducts()  
    }  
}
