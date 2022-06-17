//
//  main.swift
//
//  Created by Kevin Turner on 2/3/22.
//
import Foundation
import CoreImage
import Cocoa
import Vision

var joiner = " "

func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
    let context = CIContext(options: nil)
    if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
        return cgImage
    }
    return nil
}

@available(macOS 10.15, *)
func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations =
            request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        return observation.topCandidates(1).first?.string
    }

    // Process the recognized strings.
    let joined = recognizedStrings.joined(separator: joiner)
    print(joined)

    let pasteboard = NSPasteboard.general
    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.setString(joined, forType: .string)

}

@available(macOS 10.15, *)
func detectText(fileName : URL) -> [CIFeature]? {
    if let ciImage = CIImage(contentsOf: fileName){
        guard let img = convertCIImageToCGImage(inputImage: ciImage) else { return nil}

        let requestHandler = VNImageRequestHandler(cgImage: img)

        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.recognitionLanguages = recognitionLanguages


        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
}
    return nil
}


var recognitionLanguages = ["en-US"]
let arguments = Array(CommandLine.arguments.dropFirst())

// We could do a lot more to manage cli options and arguments for simplicity sake, we
// are going to require the image file as an argument.
if #available(macOS 10.15, *) {
    if let features = detectText(fileName : URL(fileURLWithPath: arguments.first!)), !features.isEmpty {
        // print(features) // We've already printed the features.
    }
} else {
    print("This version of macOS does not support Vision.")
}

exit(EXIT_SUCCESS)
