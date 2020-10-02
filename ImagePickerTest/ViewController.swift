import UIKit
import SwiftUI

class ViewController: UIViewController {


    @IBAction func tapButton(_ sender: Any) {
        let navController = UINavigationController(navigationBarClass: UINavigationBar.self, toolbarClass: nil)
        let view = ImageView()
        let viewController = UIHostingController(rootView: view)
        navController.setViewControllers([viewController], animated: false)
        present(navController, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

struct ImageView: View {
    @State private var showSheet = false
    @State private var originalImage: UIImage?

    var body: some View {
        let imageBinding = Binding<UIImage?>(
            get: {
                self.originalImage
            },
            set: {
                self.originalImage = $0
            }
        )

        Button {
            showSheet = true
        } label: {
            if let image = originalImage {
            Image(uiImage: image)
            } else {
                Text("Add Image")
            }
        }
        .sheet(isPresented: $showSheet) {
            PHPickerView(image: imageBinding)
        }
    }
}

