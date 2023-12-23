//
//  Coordinator.swift
//  EMTstapp
//
//  Created by ARMBP on 12/18/23.
//

import SwiftUI

enum Page: String, Identifiable {
    case main, detail, book, success
    
    var id: String {
        self.rawValue
    }
}

//enum Sheet: String, Identifiable {
//    case one, two, three
//    
//    var id: String {
//        self.rawValue
//    }
//}
//
//
//enum FullScreenCover: String, Identifiable {
//    case bee
//    
//    var id: String {
//        self.rawValue
//    }
//}


class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
     private let networkManager = NetworkManager()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    //MARK: - ViewBuilders
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .main:
            HotelScreen()
        case .detail:
            HotelDetailScreen()
        case .book:
            HotelBookScreen()
        case .success:
            SuccessPaidScreen()
        }
    }
}
