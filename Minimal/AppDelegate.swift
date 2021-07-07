//
//  Copyright © 2014-2021 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import UIKit
import PSPDFKitUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Set your license key here. PSPDFKit is commercial software.
        // Each PSPDFKit license is bound to a specific app bundle id.
        // Visit https://customers.pspdfkit.com to get your demo or commercial license key.
        SDK.setLicenseKey("YOUR_LICENSE_KEY_GOES_HERE")

        return true
    }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = UIColor.white

        let fileURL = Bundle.main.bundleURL.appendingPathComponent("Samples/PSPDFKit 10 QuickStart Guide.pdf")
        let writableURL = copyFileURLToDocumentFolder(fileURL)
        let document = Document(url: writableURL)
        let configuration = PDFConfiguration { builder in
            builder.thumbnailBarMode = .scrollable
        }
        let pdfController = PDFSimpleViewController(document: document, configuration: configuration)

        window.rootViewController = UINavigationController(rootViewController: pdfController)
        window.makeKeyAndVisible()

        // Example how to use the library and start background indexing.
        DispatchQueue.global().async {
            let libraryExample = LibraryExample()
            libraryExample.indexDocuments()
        }

        return true
    }

    private func copyFileURLToDocumentFolder(_ documentURL: URL, override: Bool = false) -> URL {
        let docsURL = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!))
        let newURL = docsURL.appendingPathComponent(documentURL.lastPathComponent)
        let needsCopy = !FileManager.default.fileExists(atPath: newURL.path)
        if override {
            _ = try? FileManager.default.removeItem(at: newURL)
        }
        if needsCopy || override {
            do {
                try FileManager.default.copyItem(at: documentURL, to: newURL)
            } catch let error as NSError {
                print("Error while copying \(documentURL.path): \(error.description)")
            }
        }
        return newURL
    }
}
