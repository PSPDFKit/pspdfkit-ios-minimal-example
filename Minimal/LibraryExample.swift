//
//  Copyright © 2014-2025 PSPDFKit GmbH. All rights reserved.
//
//  The Nutrient Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import Foundation
import PSPDFKit

class LibraryExample {

    func indexDocuments() {
        guard let library = SDK.shared.library else { return }
        let filesURL = Bundle.main.resourceURL!.appendingPathComponent("Samples")

        let dataSource = LibraryFileSystemDataSource(library: library, documentsDirectoryURL: filesURL)
        library.dataSource = dataSource
        library.updateIndex()

        // Indexing is async. We could use notifications to track the state,
        // but for this example it's easy enough to just delay this for a second.
        // This approach should not be used in production.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            library.documentUIDs(matching: "pdf", options: nil, completionHandler: { searchString, resultSet -> Void in
                print("For \(searchString) found \(resultSet)")
            }, previewTextHandler: nil)
        }
    }
}
