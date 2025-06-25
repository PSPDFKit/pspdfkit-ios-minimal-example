//
//  Copyright © 2014-2025 PSPDFKit GmbH. All rights reserved.
//
//  The Nutrient Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import UIKit
import PSPDFKitUI

class PDFSimpleViewController: PDFViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        processorExample()
    }

    /// Sample call how to use `Processor` in Swift.
    func processorExample() {
        guard let document else { return }

        let indexSet = IndexSet(integersIn: 0..<Int(document.pageCount))
        let url = URL(fileURLWithPath: (NSTemporaryDirectory() as NSString).appendingPathComponent("export.pdf"))
        guard let configuration = Processor.Configuration(document: document) else { return }
        configuration.includeOnlyIndexes(indexSet)
        do {
            let processor = Processor(configuration: configuration, securityOptions: nil)
            processor.delegate = self
            try processor.write(toFileURL: url)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

// MARK: ProcessorDelegate

extension PDFSimpleViewController: ProcessorDelegate {
    public func processor(_ processor: Processor, didProcessPage currentPage: UInt, totalPages: UInt) {
        print("Progress: \(currentPage + 1) of \(totalPages)")
    }
}

// MARK: PDFViewControllerDelegate

extension PDFSimpleViewController: PDFViewControllerDelegate {

    func pdfViewController(_ pdfController: PDFViewController, didConfigurePageView pageView: PDFPageView) {
        print("Page loaded: %@", pageView)
    }
}
