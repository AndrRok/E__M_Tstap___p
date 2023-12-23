//
//  HotelScreen.swift
//  EMTstapp
//
//  Created by ARMBP on 12/18/23.
//

import SwiftUI

struct  HotelScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: ViewModel
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    @State var selection: Int = 0
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(alignment: .center, spacing: 0){
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading){
                        ImagePageScroll(hotel: self.viewModel.homeInitialHotel)
                            .padding(.vertical, 16)
                        HStack{
                            Image(systemName: "star.fill")
                            Text(String(viewModel.homeInitialHotel?.rating ?? 0))
                            Text(viewModel.homeInitialHotel?.ratingName ?? "")
                        }
                        .padding(8)
                        .foregroundStyle(Color(UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)))
                        .background(RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(Color(UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)))
                        )
                        Text("Steigenberger Makadi")// c Xcode 15 он сам записывает строки в localizable
                            .font(.system(size: 22, weight: .medium))
                            .padding(.bottom, 8)
                        Text(viewModel.homeInitialHotel?.adress ?? "")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.blue)
                            .padding(.bottom, 16)
                        HStack{
                            Text("от \(self.viewModel.addSpacesToEveryThreeCharacters(in: String(self.viewModel.homeInitialHotel?.minimalPrice ?? 0)))" + " ₽")
                                .font(.system(size: 30, weight: .semibold))
                            Text(viewModel.homeInitialHotel?.priceForIt?.lowercased() ?? "")
                                .font(.system(size: 16))
                                .foregroundStyle(Color(UIColor(red: 0.51, green: 0.53, blue: 0.59, alpha: 1)))
                        }
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
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Об отеле")
                                .font(.system(size: 22, weight: .medium))
                            Spacer()
                        }
                        .padding(16)
                        
                        FlexibleView(
                            availableWidth: geometryProxy.size.width,
                            data: self.viewModel.homeInitialHotel?.aboutTheHotel?.peculiarities ?? [],
                            spacing: 15,
                            alignment: .leading
                        ) { item in
                            Text(item)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color(red: 0.51, green: 0.53, blue: 0.59))
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 0.98, green: 0.98, blue: 0.99))
                                )
                        }
                        .padding(16)
                        
                        Text(self.viewModel.homeInitialHotel?.aboutTheHotel?.description ?? "")
                            .padding([.bottom, .horizontal], 16)
                        VStack(alignment: .leading){
                            HStack{
                                Image("emoji-happy")
                                VStack(alignment: .leading){
                                    Text("Удобства")
                                    Text("Самое необходимое")
                                        .foregroundStyle(Color(UIColor(red: 0.51, green: 0.53, blue: 0.59, alpha: 1)))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            Divider()
                            HStack{
                                Image("tick-square")
                                VStack(alignment: .leading){
                                    Text("Что включено")
                                    Text("Самое необходимое")
                                        .foregroundStyle(Color(UIColor(red: 0.51, green: 0.53, blue: 0.59, alpha: 1)))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding([.bottom, .horizontal], 16)
                            Divider()
                            HStack{
                                Image("close-square")
                                VStack(alignment: .leading){
                                    Text("Что не включено")
                                    Text("Самое необходимое")
                                        .foregroundStyle(Color(UIColor(red: 0.51, green: 0.53, blue: 0.59, alpha: 1)))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                
                            }
                            .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(Color(red: 0.98, green: 0.98, blue: 0.99))
                        )
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(Color.white))
                    .padding(.bottom, 16)
                }
                .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))//scrollview
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.gray.opacity(0.1))
                    .padding(0)
                HStack{
                    Button{
                        self.coordinator.push(.detail)
                        self.viewModel.loadDetailsScreen()
                    }label:{
                        Text("К выбору номера")
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
            }
        }
        .navigationBarTitle("Отель", displayMode: .inline)
        .toolbar(.visible, for: .navigationBar)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))
    }
}
