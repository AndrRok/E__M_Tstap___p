//
//  SuccessPaidScreen.swift
//  EMTstapp
//
//  Created by ARMBP on 12/22/23.
//

import SwiftUI

struct SuccessPaidScreen: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            Spacer()
            Text("🎉")
                .font(.system(size: 42))
                .padding(32)
                .background(
                    Circle()
                        .frame(width: 95, height: 95)
                        .foregroundStyle(Color(Color(red: 0.96, green: 0.96, blue: 0.98)))  
                )
            Group{
                Text("Ваш заказ принят в работу")
                    .font(.system(size: 22, weight: .medium))
                Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(red: 0.51, green: 0.53, blue: 0.59))
            }
            .padding(.horizontal, 16)
            Spacer()
            
            //MARK: - TabBar
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.gray.opacity(0.1))
                .padding(0)
            HStack{
                Button{
                    self.coordinator.pop()
                }label:{
                    Text("Супер!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(Color.blue)
                        )
                    
                }
                .padding(.horizontal, 16)
               
            }
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
        .navigationBarTitle("Заказ оплачен", displayMode: .inline)
    }
}

#Preview {
    SuccessPaidScreen()
}
