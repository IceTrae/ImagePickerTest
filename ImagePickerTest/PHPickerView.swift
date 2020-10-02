import PhotosUI
import SwiftUI

@available(iOS 14, *)
struct PHPickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: PHPickerViewControllerDelegate {
        var parent: PHPickerView

        init(_ parent: PHPickerView) {
            self.parent = parent
        }

        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                cancelImageSelect()
                return
            }

            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.cancelImageSelect()
                } else {
                    guard let image = image as? UIImage else {
                        print("Loaded Assest is not a Image")
                        self.cancelImageSelect()
                        return
                    }

                    self.parent.image = image
                }
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        private func cancelImageSelect() {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_: PHPickerViewController, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
