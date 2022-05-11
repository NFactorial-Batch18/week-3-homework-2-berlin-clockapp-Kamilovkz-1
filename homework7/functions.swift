//
//  functions.swift
//  homework7
//
//  Created by Nail Kamilov on 10.05.2022.
//

import Foundation
import SwiftUI

struct FiveMinuteBulp: View{
    @Binding var isOn: Bool
    var isRed: Bool
    
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(self.setColor())
            .frame(width: 21, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
    
    func setColor() -> Color{
        if isRed {
            return isOn ? colors.red : colors.lightRed
        } else {
            return isOn ? colors.yellow : colors.lightYellow
        }
    }
}

struct OneMinuteBulp: View{
    @Binding var isOn: Bool
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(isOn ? colors.yellow : colors.lightYellow)
            .frame(width: 74, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
}

struct HourBulp: View{
    @Binding var isOn: Bool
    var body: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(isOn ? colors.red : colors.lightRed)
            .frame(width: 74, height: 32)
            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 6)
    }
}
