//
//  ViewModel.swift
//  EMTstapp
//
//  Created by ARMBP on 12/20/23.
//

import Foundation
import SwiftUI


final class ViewModel: ObservableObject {
    
    @Published var homeInitialHotel: Hotel?
    @Published var roomsList: Rooms?
    @Published var bookModel: BookModel?
    
    @Published var userName: String = ""
    @Published var userSecondName: String = ""
    @Published var userDateOfBirth: String = ""
    @Published var userCitizenship: String = ""
    @Published var userPassportNumber: String = ""
    @Published var userPassportValidity: String = ""
    @Published var userEmail: String = ""
    @Published var userPhone: String = ""
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.loadHomeScreen()
    }
    
    func loadHomeScreen(){
        networkManager.getMainRequest() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let hotelResult):
                DispatchQueue.main.async {
                    self.homeInitialHotel = hotelResult
                }
                
            case .failure(let error):
                print("!!!", error)
            }
        }
    }
    
    func loadDetailsScreen(){
        networkManager.getDetails() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let roomsResult):
                DispatchQueue.main.async {
                    self.roomsList = roomsResult
                }
            case .failure(let error):
                print("!!!", error)
            }
        }
    }
    
    func loadBook(){
        networkManager.getBook() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookResult):
                DispatchQueue.main.async {
                    self.bookModel = bookResult
                    print(bookResult)
                }
            case .failure(let error):
                print("!!!", error)
            }
        }
    }
    
    //MARK: - Utility Functions
    func calculatePrice() -> String{
        let finalPrice = (bookModel?.tourPrice ?? 0) + (bookModel?.fuelCharge ?? 0) + (bookModel?.serviceCharge ?? 0)
        return  self.addSpacesToEveryThreeCharacters(in: String(finalPrice)) + " ₽"
    }
    
    func addSpacesToEveryThreeCharacters(in string: String) -> String {
        var result = ""
        var index = 0
        
        
        for char in string.reversed() {
            if index % 3 == 0 && index != 0 { // Добавляем пробел после каждых трех символов, кроме самого начала строки
                result.append(" ")
            }
            result.append(char)
            index += 1
        }
        return String(result.reversed())
    }
    
    func checkFill() -> Bool{
        if         userName.isEmpty
                || userSecondName.isEmpty
                || userDateOfBirth.isEmpty
                || userCitizenship.isEmpty
                || userPassportNumber.isEmpty
                || userPassportValidity.isEmpty
                || userEmail.isEmpty
                || userPhone.isEmpty
        { return false }
        else { return true }
    }
}
