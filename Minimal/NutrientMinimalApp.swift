//
//  Copyright © 2025-2026 PSPDFKit GmbH. All rights reserved.
//
//  The Nutrient Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import PSPDFKit
import SwiftUI

@main
struct NutrientMinimalApp: App {
    static private let readOnlyDocumentURL = Bundle.main.url(forResource: "Nutrient welcome", withExtension: "pdf", subdirectory: "Samples")!
    static private let writableDocumentURL = URL.documentsDirectory.appending(path: readOnlyDocumentURL.lastPathComponent)

    init() {
        // Set your license key before calling any other Nutrient API.
        // Nutrient is commercial software.
        // Each Nutrient license is bound to a specific app bundle ID.
        // Visit https://my.nutrient.io/ to get your demo or commercial license key.
        PSPDFKit.SDK.setLicenseKey("YOUR_LICENSE_KEY_GOES_HERE")

        // Copy the sample PDF from the app bundle into a writable location.
        do {
            try FileManager.default.copyItem(at: Self.readOnlyDocumentURL, to: Self.writableDocumentURL)
        } catch CocoaError.fileWriteFileExists {
            // Already copied. Don’t replace the file for this example.
        } catch {
            print("Error copying sample document: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ExampleDocumentView(document: Document(url: Self.writableDocumentURL))
        }
    }
}
