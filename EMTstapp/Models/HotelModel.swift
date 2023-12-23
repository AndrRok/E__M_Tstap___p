//
//  HotelModel.swift
//  EMTstapp
//
//  Created by ARMBP on 12/20/23.
//

import Foundation

//MARK: - Hotel Request Model
struct Hotel: Decodable {
    let id: Int?
    let name: String?
    let adress: String?
    let minimalPrice: Int?
    let priceForIt: String?
    let rating: Int?
    let ratingName: String?
    let imageUrls: [String]?
    let aboutTheHotel: AboutTheHotel?
}

struct AboutTheHotel: Decodable {
    let description: String?
    let peculiarities: [String]?
}

//MARK: - Details request model
struct Rooms: Decodable {
    let rooms: [Room]?
}

struct Room: Decodable {
    let id: Int?
    let name: String?
    let price: Int?
    let pricePer: String?
    let peculiarities: [String]?
    let imageUrls: [String]?
}

//MARK: - Booking Model
struct BookModel: Decodable {
    let id: Int?
    let hotelName: String?
    let hotelAdress: String?
    let horating: Int?
    let ratingName: String?
    let departure: String?
    let arrivalCountry: String?
    let tourDateStart: String?
    let tourDateStop: String?
    let numberOfNights: Int?
    let room: String?
    let nutrition: String?
    let tourPrice: Int?
    let fuelCharge: Int?
    let serviceCharge: Int?
}

