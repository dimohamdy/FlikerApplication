import SwiftUI
import NetworkLayer
import Kingfisher
import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject private var photoModel: PhotoModel

    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(photoModel.data, id: \.self) { photo in

                    KFImage.url(URL(string: photo.imagePath))
                        .resizable()
                        .placeholder {
                            Color.red
                        }
                        .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 500, height: 500)))
                        .fade(duration: 0.25)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
            .padding()
        }
    }

    var body: some View {

        switch photoModel.state {
        case .error:
            Text("Error ")
        case .loading:
            MonjasaProgressView()
        default:
            NavigationView {

                gridView.searchable(text: $photoModel.text) {
                    Text("Search")
                }.onChange(of: photoModel.debouncedText) { text in
                    // perform search
                    Task {
                        try? await self.photoModel.searchForPhoto(query: text)
                    }
                }.navigationTitle("Photos")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
