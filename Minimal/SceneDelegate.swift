//
//  Copyright © 2021-2025 PSPDFKit GmbH. All rights reserved.
//
//  The Nutrient Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import UIKit
import PSPDFKit
import PSPDFKitUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let fileURL = Bundle.main.url(forResource: "PSPDFKit 14 Quickstart Guide", withExtension: "pdf", subdirectory: "Samples")!
        let writableURL = copyFileURLToDocumentFolder(fileURL)
        let document = Document(url: writableURL)

        let pdfController = PDFSimpleViewController(document: document) { builder in
            builder.thumbnailBarMode = .scrollable
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: pdfController)
        window.makeKeyAndVisible()
        self.window = window

        // Example how to use the library and start background indexing.
        DispatchQueue.global().async {
            let libraryExample = LibraryExample()
            libraryExample.indexDocuments()
        }
    }

    private func copyFileURLToDocumentFolder(_ documentURL: URL) -> URL {
        let documentsURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
        let newURL = documentsURL.appendingPathComponent(documentURL.lastPathComponent)
        if !FileManager.default.fileExists(atPath: newURL.path) {
            do {
                try FileManager.default.copyItem(at: documentURL, to: newURL)
            } catch {
                print("Error while copying \(documentURL): \(error)")
            }
        }
        return newURL
    }

}
