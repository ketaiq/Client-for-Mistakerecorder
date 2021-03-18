//
//  PDFActivityViewController.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/7.
//

import SwiftUI
import UIKit

struct PDFActivityViewController: UIViewControllerRepresentable {
    var pdfData: Data
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
