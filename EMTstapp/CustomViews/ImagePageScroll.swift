//
//  ImagePageScroll.swift
//  EMTstapp
//
//  Created by ARMBP on 12/22/23.
//

import SwiftUI

struct ImagePageScroll: View {
    
    let room: Room?
    let hotel: Hotel?
    @State private var selection = 0
    
    init(room: Room? = nil, hotel: Hotel? = nil) {
        self.room = room
        self.hotel = hotel
    }
    
    var body: some View {
       
            TabView(selection : $selection){
                ForEach(0...((room == nil) ?  hotel?.imageUrls?.count ?? 1 : room?.imageUrls?.count ?? 1) - 1 , id: \.self){ i in
                    AsyncImage(url: URL(string: (room == nil) ? hotel?.imageUrls?[i] ?? "" : room?.imageUrls?[i] ?? ""))
                        .tag(i)
                        .frame(maxWidth: 400, maxHeight: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
           
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: 400, height: 400)
            .overlay(alignment: .bottom) {
                CustomSegmentedPickerView(selectedIndex: $selection, count: (room == nil) ? hotel?.imageUrls?.count ?? 0 : room?.imageUrls?.count ?? 0)
                    .padding(8)
            }
        }
    }

