//
//  AvocadoGif.swift
//  MoveMint
//
//  Created by Ellie on 9/14/23.
//

import SwiftUI
import WebKit

struct AvocadoGif: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct AvocadoGif_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoGif("avocado")
    }
}
