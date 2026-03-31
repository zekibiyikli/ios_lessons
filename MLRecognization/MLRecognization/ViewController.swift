//
//  ViewController.swift
//  MLRecognization
//
//  Created by Zeki Mac on 31.03.2026.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
        if let ciImage = CIImage(image:imageView.image!){
            recognizeImage(ciImage: ciImage)
        }
        
    }
    
    func recognizeImage(ciImage:CIImage){
        
        resultLabel.text = "Finding ..."
        
        if let model = try? VNCoreMLModel(for:MobileNetV2(configuration: MLModelConfiguration()).model){
            let request = VNCoreMLRequest(model: model){ vnRequest, error in
                if let results = vnRequest.results as? [VNClassificationObservation]{
                    if results.count > 0{
                        let topResult = results.first
                        
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0)*100
                            self.resultLabel.text = "\(topResult?.identifier ?? "Not Found") \(confidenceLevel.rounded())%"
                        }
                    }else{
                        self.resultLabel.text = "Not Found"
                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global(qos: .userInitiated).async {
                do{
                    try handler.perform([request])
                }catch {
                    self.resultLabel.text = "Error"
                }
            }

        }
    }
}

