//
//  ProgressBar.swift
//  meteoProject
//
//  Created by cyril perier on 13/06/2023.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 20
    var height: CGFloat = 20
    var percent: CGFloat = 50
    var color1 = Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var body: some View {
        let multiplier = width / 100
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height,style: .continuous)
                .frame(width:width,height: height)
            .foregroundColor(Color.black.opacity(0.1))
            RoundedRectangle(cornerRadius: height,style: .continuous)
                .frame(width:percent * multiplier,height: height)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: height,style: .continuous))
                )
                .foregroundColor(.clear)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
