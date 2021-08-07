import SwiftUI

struct CarrouselView<Content: View, T: Identifiable>: View {
    
    var content: (T) -> Content
    var items: [T]
    
    @Binding var index: Int
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0

    init(index: Binding<Int>, spacing: CGFloat = 15, trailingSpace: CGFloat = 100, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self._index = index
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.items = items
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack (spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            } // HStack
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ?  adjustMentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        
                        let roundedIndex = progress.rounded()
                        
                        currentIndex = max(min(currentIndex + Int(roundedIndex), items.count - 1), 0)
                        
                        currentIndex = index
                        
                    }) // DragGesture
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        
                        let roundedIndex = progress.rounded()
                        
                        index = max(min(currentIndex + Int(roundedIndex), items.count - 1), 0)
                    })
            ) // gesture
        } // GeometryReader
        .animation(.easeInOut, value: offset == 0)
    }
}
