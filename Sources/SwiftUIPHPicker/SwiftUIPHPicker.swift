//
//  SwiftUIPHPicker.swift
//
//  Created by : Tomoaki Yagishita on 2020/12/07
//  © 2020  SmallDeskSoftware
//

import Foundation
import SwiftUI
import PhotosUI
import os

typealias PHPickerViewCompletionHandler = ( ([PHPickerResult]) -> Void)

public struct SwiftUIPHPicker: UIViewControllerRepresentable {
    var configuration: PHPickerConfiguration
    var completionHandler: PHPickerViewCompletionHandler?
    
    let logger = Logger(subsystem: "com.smalldesksoftware.SwiftUIPHPicker", category: "SwiftUIPHPicker")
    
    public func makeCoordinator() -> Coordinator {
        logger.debug("makeCoordinator called")
        return Coordinator(self)
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        logger.debug("makeUIViewController called")
        let viewController = PHPickerViewController(configuration: configuration)
        viewController.delegate = context.coordinator
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        logger.debug("updateUIViewController called")
    }
    
    
    public class Coordinator : PHPickerViewControllerDelegate {
        let parent: SwiftUIPHPicker
        
        init(_ parent: SwiftUIPHPicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.logger.debug("didFInishPicking called")
            picker.dismiss(animated: true)
            self.parent.completionHandler?(results)
        }
    }

}
