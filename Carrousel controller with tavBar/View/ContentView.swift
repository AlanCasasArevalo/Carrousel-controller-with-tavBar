import SwiftUI

struct ContentView: View {
    
    @State var currentIndex: Int = 0
    @State var posts: [Post] = []
    
    var body: some View {
        VStack (spacing: 15) {
            VStack (alignment: .leading, spacing: 12) {
                Button(action: {
                    
                }, label: {
                    Label {
                        Text("Back")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                    }
                    .foregroundColor(.primary)
                })
                
                Text("My wishes")
                    .font(.title)
                    .fontWeight(.semibold)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            CarrouselView(index: $currentIndex, items: posts) { post in
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width)
                        .cornerRadius(12)
                }
            } // CarrouselView
            .padding(.vertical, 80)
            
            IndicatorView(items: posts, circleColor: .black, currentIndex: currentIndex)
        }
        .onAppear {
            for index in 1...5 {
                posts.append(Post(postImage: "post\(index)"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
