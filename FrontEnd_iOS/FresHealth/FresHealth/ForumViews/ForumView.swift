import SwiftUI

struct ForumView: View {
    @StateObject var viewModel = PostViewModel()
    @State private var showingAddPostView = false

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.posts) { post in
                    NavigationLink(destination: PostDetailView(post: post)
                                    .environmentObject(viewModel)) {
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text("\(Date(timeIntervalSince1970: post.timestamp), formatter: dateFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchPosts()
                }
                .navigationTitle("Posts")
                .onAppear {
                    viewModel.fetchPosts()
                }

                Button(action: {
                    showingAddPostView = true
                }) {
                    Text("Add New Post")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showingAddPostView) {
                    AddPostView(viewModel: viewModel)
                }
            }
        }
    }
}

struct PostDetailView: View {
    var post: Post
    @State private var showingComments = false
    @EnvironmentObject var viewModel: PostViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.title)
                .font(.largeTitle)
            Text("\(Date(timeIntervalSince1970: post.timestamp), formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)
            if let imageURL = post.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(height: 200)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(post.content)
                .font(.body)

            Spacer()

            Button(action: {
                showingComments = true
            }) {
                HStack {
                    Text("Comments (\(post.comments.count))")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showingComments) {
                PostCommentView(post: post)
                    .environmentObject(viewModel)
            }
        }
        .padding()
        .navigationTitle("Post Details")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    ForumView()
}
