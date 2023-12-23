//
//  CustomSegmentedPickerView.swift
//  EMTstapp
//
//  Created by ARMBP on 12/23/23.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    
    init(selectedIndex: Binding<Int>, count: Int) {
        self._selectedIndex = selectedIndex
        self.count = count
    }
    
    @Binding var selectedIndex: Int
    let count: Int
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<count, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    Circle()
                        .foregroundColor(selectedIndex == index ? Color.black : Color.gray.opacity(opacity(for: index)))
                        .frame(width: 7, height: 7)
                        .contentShape(Rectangle())
                        .padding(.trailing, (index == count - 1) ? 0 : 5)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.white)
        )
    }
    
    private func opacity(for index: Int) -> Double {
        let distance = Double(abs(index - selectedIndex))
        return Double(max(1 - (distance * 0.3), 0))
    }
}
