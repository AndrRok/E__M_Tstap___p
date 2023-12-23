//
//  DropDownView.swift
//  EMTstapp
//
//  Created by ARMBP on 12/23/23.
//

import SwiftUI

struct DropDownView<Title: View, Content: View>: View {
    @State var isShow: Bool = true
    let title: () -> Title
    let content: () -> Content
    
    var body: some View {
        VStack {
            HStack {
                title()
                Spacer()
                customChevron
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isShow.toggle()
                }
            }
            if isShow {
                content()
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        }
    }
    
    @ViewBuilder
    private var customChevron: some View {
        HStack {
            Capsule()
                .rotation(Angle(degrees: isShow ? -45 : 45))
                .frame(width: 10, height: 2)
                .padding(.trailing,-6)
            Capsule()
                .rotation(Angle(degrees: isShow ? 45 : -45))
                .frame(width: 10, height: 2)
                .padding(.leading,-6)
        }
        .foregroundStyle(Color.blue)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.blue).opacity(0.1)
            
        )
    }
}
