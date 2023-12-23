//
//  HotelBookScreen.swift
//  EMTstapp
//
//  Created by ARMBP on 12/18/23.
//

import SwiftUI

struct HotelBookScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: ViewModel
    @State var touristsCount: Int = 1//кол-во туристов
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(alignment: .center, spacing: 0){
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Image(systemName: "star.fill")
                            Text(String(viewModel.bookModel?.horating ?? 0))
                            Text(viewModel.bookModel?.ratingName ?? "")
                        }
                        .padding(8)
                        .foregroundStyle(Color(UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)))
                        .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(Color(UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)))
                                    
                        )
                        .padding(.top, 16)
                        
                        Text("Steigenberger Makadi")
                            .foregroundStyle(Color.blue)
                        Text(viewModel.bookModel?.hotelAdress ?? "")
                            .padding(.bottom, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundStyle(Color.white)
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    VStack(alignment: .leading){
                        
                        HStack(alignment: .top, spacing: 0){
                            VStack(alignment: .leading, spacing: 8){
                                Text("Вылет из")
                                Text("Страна, город")
                                Text("Даты")
                                Text("Кол-во ночей")
                                Text("Отель")
                                Text("Номер")
                                Text("Питание")
                            }
                            .font(.system(size: 16))
                            .foregroundStyle(Color(red: 0.51, green: 0.53, blue: 0.59))
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text(viewModel.bookModel?.departure ?? "")
                                Text(viewModel.bookModel?.arrivalCountry ?? "")
                                Text(String(viewModel.bookModel?.tourDateStart  ?? "") + " - " + String(viewModel.bookModel?.tourDateStop ?? ""))
                                Text(String(viewModel.bookModel?.numberOfNights ?? 0) + " ночей")
                                Text("Steigenberger Makadi")
                                Text(viewModel.bookModel?.room ?? "")
                                Text(viewModel.bookModel?.nutrition ?? "")
                            }
                            .font(.system(size: 16))
                        }
                        .padding(16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundStyle(Color.white)
                    )
                    .padding(.bottom, 8)
                    
                    VStack(alignment: .leading){
                        Text("Информация о покупателе")
                            .padding([.horizontal, .top], 16)
                        
                        Group{
                            CustomTextField(emailMode: false, phoneMode: true, placeHolder: "Номер телефона", bodyText: $viewModel.userPhone)
                            CustomTextField(emailMode: true, phoneMode: false, placeHolder: "Почта", bodyText: $viewModel.userEmail)
                        }
                        .padding(.horizontal, 8)
                        
                        Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                            .foregroundColor(Color(red: 0.66, green: 0.67, blue: 0.72))
                            .padding(16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundStyle(Color.white)
                    )
                    .padding(.bottom, 8)
                    
                    ForEach(0...self.touristsCount, id: \.self) { i in //в принципе можно до бесконечности
                        DropDownView(isShow: i == 0 ? true : false) {
                            Text(i == 0 ? "Первый турист" : "Второй турист")
                                .font(.system(size: 22))
                                .foregroundStyle(Color.black)
                        } content: {
                            VStack(alignment: .leading, spacing: 0){
                                CustomTextField(placeHolder: "Имя", bodyText: $viewModel.userName)
                                CustomTextField(placeHolder: "Фамилия", bodyText: $viewModel.userSecondName)
                                CustomTextField(placeHolder: "Дата Рождения", bodyText: $viewModel.userDateOfBirth)
                                CustomTextField(placeHolder: "Гражданство", bodyText: $viewModel.userCitizenship)
                                CustomTextField(placeHolder: "Номер загранпаспорта", bodyText: $viewModel.userPassportNumber)
                                CustomTextField(placeHolder: "Срок действия загранпаспорта", bodyText: $viewModel.userPassportValidity)
                            }
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.white))
                            .padding(.bottom, 8)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 0){
                        if   self.touristsCount < 10 {
                            Button{
                                
                                self.touristsCount += 1
                            } label: {
                                HStack{
                                    Text("Добавить туриста")
                                        .font(.system(size: 22))
                                        .foregroundStyle(Color.black)
                                    Spacer()
                                    Image(systemName: "plus.app.fill")
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .frame(width: 32, height: 32)
                                }
                                .padding(16)
                            }
                        }
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundStyle(Color.white)
                    )
                    .padding(.bottom, 8)
                    
                    VStack{
                        HStack{
                            VStack(alignment: .leading, spacing: 8){
                                Text("Тур")
                                Text("Топливный сбор")
                                Text("Сервисный сбор")
                                Text("К оплате")
                            }
                            .font(.system(size: 16))
                            .foregroundStyle(Color(red: 0.51, green: 0.53, blue: 0.59))
                            Spacer()
                            VStack(alignment: .trailing, spacing: 8){
                                Text(viewModel.addSpacesToEveryThreeCharacters(in: String(viewModel.bookModel?.tourPrice ?? 0)) + " ₽")
                                Text(viewModel.addSpacesToEveryThreeCharacters(in: String(viewModel.bookModel?.fuelCharge ?? 0)) + " ₽")
                                Text(viewModel.addSpacesToEveryThreeCharacters(in: String(viewModel.bookModel?.serviceCharge ?? 0)) + " ₽")
                                Text(viewModel.calculatePrice())
                            }
                            .font(.system(size: 16))
                        }
                        .padding(16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 12,
                                    bottomTrailingRadius: 12,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundStyle(Color.white)
                    )
                    .padding(.bottom, 16)
                }
                .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))//scrollview
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.gray.opacity(0.1))
                    .padding(0)
                HStack{
                    Button{
                        self.coordinator.push(.success)
                    }label:{
                        Text("Оплатить " + viewModel.calculatePrice())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(Color.blue)
                            )
                    }
                    .padding()
                }
                .background(Color.white)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.coordinator.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Бронирование", displayMode: .inline)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))
        }
    }
}

#Preview {
    HotelBookScreen()
}
