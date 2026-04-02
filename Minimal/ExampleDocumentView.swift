//
//  Copyright © 2025-2026 PSPDFKit GmbH. All rights reserved.
//
//  The Nutrient Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import PSPDFKit
import PSPDFKitUI
import SwiftUI

struct ExampleDocumentView: View {
    let document: Document
    @PDFView.Scope private var scope

    var body: some View {
        NavigationStack {
            PDFView(document: document)
                .toolbar {
                    // Add the default toolbar items.
                    DefaultToolbarButtons()
                }
                // Set the scope for the view hierarchy so the default toolbar buttons and the PDFView can communicate.
                .pdfViewScope(scope)
        }
    }
}
