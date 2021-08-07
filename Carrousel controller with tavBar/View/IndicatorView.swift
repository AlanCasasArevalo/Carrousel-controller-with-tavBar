import SwiftUI

struct IndicatorView <T: Identifiable>: View {
    
    var items: [T]
    var circleColor: Color
    var width: CGFloat = 10
    var height: CGFloat = 10
    var currentIndex: Int

    init (items: [T], circleColor: Color, currentIndex: Int) {
        self.items = items
        self.circleColor = circleColor
        self.currentIndex = currentIndex
    }
    
    var body: some View {
        HStack (spacing: 10) {
            ForEach(items.indices, id: \.self) { index in
                Circle()
                    .fill(circleColor.opacity(currentIndex == index ? 1 : 0.1 ))
                    .frame(width: width, height: height)
                    .scaleEffect(currentIndex == index ? 1.4 : 1)
                    .animation(.spring(), value: currentIndex == index)
            }
        }
    }
}
