//
//  AppProgressBar.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/25/24.
//

import SwiftUI

struct AppProgressBar: View {
    @Binding var width: CGFloat
    var height: CGFloat = 12
    var cornerRadius: CGFloat
    @Binding var percentOfProgress: CGFloat
    
    var colors: [Color]  {
        if percentOfProgress < 25 {
            return withAnimation(.easeInOut) { [Color.red, Color.blue] }
        }
        else if percentOfProgress < 45 {
            return withAnimation(.easeInOut) {  [Color.orange, Color.blue] }
        }
        else if percentOfProgress < 65 {
            return withAnimation(.easeInOut) {  [Color.yellow, Color.blue] }
        }
        else if percentOfProgress < 85 {
            return withAnimation(.easeInOut) {  [Color.green, Color.blue] }
        }
        else {
            return withAnimation(.easeInOut) {  [Color.blue, Color.blue.opacity(0.4)] }
        }
    }
    
    var multiplier: CGFloat {
        width / 100
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(.black)
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .frame(width: multiplier * percentOfProgress, height: height)
                .foregroundColor(.clear)
                .background(
                    LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                )
        }
    }
}

//struct AppProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        AppProgressBar(width: 155)
//    }
//}

