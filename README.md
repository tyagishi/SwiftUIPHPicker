# SwiftUIPHPicker

Simple SwiftUI wrapper for PHPickerViewController

## Example App with SwiftUIPHPicker

<img src="https://user-images.githubusercontent.com/6419800/101324664-f3759880-38ad-11eb-8c7f-36f74e81d5ac.gif" width="300">

## Example App (code)
```
//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/12/07
//  © 2020  SmallDeskSoftware
//

import SwiftUI
import PhotosUI
import os
import SwiftUIPHPicker

struct ContentView: View {
    @State private var images:[UIImage] = []
    @State private var showPHPicker:Bool = false
    static var config: PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        return config
    }
    let logger = Logger(subsystem: "com.smalldesksoftware.PHPickerSample", category: "PHPickerSample")

    var columns: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showPHPicker.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                })
            }
            .padding()
            Spacer()
            LazyVGrid(columns: columns) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable().scaledToFit()
                }
            }
            .padding()
            Spacer()
        }
        .sheet(isPresented: $showPHPicker) {
            SwiftUIPHPicker(configuration: ContentView.config) { results in
                for result in results {
                    let itemProvider = result.itemProvider
                    if itemProvider.canLoadObject(ofClass: UIImage.self) {
                        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                            if let image = image as? UIImage {
                                DispatchQueue.main.async {
                                    self.images.append(image)
                                }
                            }
                            if let error = error {
                                logger.error("\(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
