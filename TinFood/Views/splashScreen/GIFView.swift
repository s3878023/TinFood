//
//  GIFView.swift
//  TinFood
//
//  Created by Đại Đức on 23/09/2023.
//

import SwiftUI
import UIKit
import WebKit

struct GIFView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFit
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let gifPath = Bundle.main.path(forResource: gifName, ofType: "gif") {
            let fileURL = URL(fileURLWithPath: gifPath)
            let request = URLRequest(url: fileURL)
            uiView.load(request)
        }
    }
}
