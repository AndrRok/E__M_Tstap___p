//
//  HotelDetailScreen.swift
//  EMTstapp
//
//  Created by ARMBP on 12/18/23.
//

import SwiftUI

struct HotelDetailScreen: View {
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
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(alignment: .center, spacing: 0){
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(viewModel.roomsList?.rooms ?? [], id: \.id){ room in
                        VStack(alignment: .leading, spacing: 0){
                            ImagePageScroll(room: room)
                                .padding(.init(top: 16, leading: 16, bottom: 8, trailing: 16))
                            Text(room.name ?? "")
                                .font(.system(size: 22, weight: .medium))
                                .padding([.bottom, .horizontal], 16)
                            FlexibleView(
                                availableWidth: geometryProxy.size.width,
                                data: room.peculiarities ?? [],
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
                            .padding([.bottom, .horizontal], 16)
                            
                            Button {
                                
                            }label: {
                                HStack{
                                    Text("Подбробнее о номере")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.blue)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
                                )
                            }
                            .padding([.bottom, .horizontal], 16)
                            
                            HStack{
                                Text(viewModel.addSpacesToEveryThreeCharacters(in: String(room.price ?? 0)) + " ₽")
                                    .font(.system(size: 30, weight: .semibold))
                                Text(String(room.pricePer ?? "").lowercased())
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(UIColor(red: 0.51, green: 0.53, blue: 0.59, alpha: 1)))
                            }
                            .padding(.leading, 16)
                            
                            Button{
                                self.coordinator.push(.book)
                                self.viewModel.loadBook()
                            }label:{
                                Text("Выбрать номер")
                                
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
                        
                    }
                    .padding(.vertical, 8)
                }
                .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))//scrollview
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.coordinator.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Steigenberger Makadi", displayMode: .inline)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1)))
        }
    }
}

#Preview {
    HotelDetailScreen()
}
