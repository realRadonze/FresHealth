//
//  AIView.swift
//  FresHealth
//
//  Created by mac on 2024/12/18.
//

import SwiftUI
import WebKit

struct AIView: View {
    let url: URL
    @State private var webView: WKWebView?

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    webView?.goBack()
                }) {
                    Text("Back")
                }
                .disabled(!(webView?.canGoBack ?? false))

                Button(action: {
                    webView?.goForward()
                }) {
                    Text("Forward")
                }
                .disabled(!(webView?.canGoForward ?? false))
            }
            .padding()

            WebView(url: url, webView: $webView)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var webView: WKWebView?

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finished loading: \(webView.url?.absoluteString ?? "")")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        self.webView = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
