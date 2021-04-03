//
//  ImagePicker.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/13.
//

import SwiftUI
import AVFoundation

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct CustomImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Binding var captureButtonPressed: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> CustomImagePickerController {
        let imagePicker = CustomImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ customImagePickerController: CustomImagePickerController, context: Context) {
        if self.captureButtonPressed {
            customImagePickerController.captureButtonDidPress()
        }
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
        let parent: CustomImagePicker
        
        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            self.parent.captureButtonPressed = false
            if let imageData = photo.fileDataRepresentation() {
                var image = UIImage(data: imageData)!
                image = self.rotate90degrees(image)
                image = self.rotate90degrees(image)
                image = self.rotate90degrees(image)
                self.parent.selectedImage = image
            }
        }
        
        private func rotate90degrees(_ image: UIImage) -> UIImage {
            let ciimage = CIImage(image: image)
            let filter = CIFilter(name: "CIAffineTransform")!
            filter.setValue(ciimage, forKey: kCIInputImageKey)
            filter.setDefaults()

            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, .pi / 2, 0, 0, 1)
            let affineTransform = CATransform3DGetAffineTransform(transform)
            filter.setValue(NSValue(cgAffineTransform: affineTransform), forKey: "inputTransform")

            let context = CIContext(options: [CIContextOption.useSoftwareRenderer: true])
            let outputImage = filter.outputImage!
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent)!
            return UIImage(cgImage: cgImage)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class CustomImagePickerController: UIViewController {
    var image: UIImage?
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var delegate: AVCapturePhotoCaptureDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    public func captureButtonDidPress() {
        self.photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self.delegate!)
    }
    
    private func initialize() {
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let deviceDiscovreySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        for device in deviceDiscovreySession.devices {
            switch device.position {
            case AVCaptureDevice.Position.front:
                self.frontCamera = device
            case AVCaptureDevice.Position.back:
                self.backCamera = device
            default:
                break
            }
        }
        self.currentCamera = self.backCamera // 默认使用后面的摄像头
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: self.currentCamera!)
            self.captureSession.addInput(captureDeviceInput)
            self.photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            self.captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
        
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
        
        self.captureSession.startRunning()
    }
}
