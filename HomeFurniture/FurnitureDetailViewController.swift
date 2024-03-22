//
//  FurnitureDetailViewController.swift
//  HomeFurniture
//
//  Created by Berlin Thomas on 2024-03-21.
//

import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var furniture: Furniture?
    
    @IBOutlet var furnitureImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    required init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

    }
    
    func updateView() {
        guard let furniture = furniture else { return }
        
        if let imageData = furniture.imageData, let image = UIImage(data: imageData) {
            furnitureImageView.image = image
        }
        else {
            furnitureImageView.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }

    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
                action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        furnitureImageView.image = selectedImage
        let imageData = selectedImage.jpegData(compressionQuality: 0.9)
        furniture?.imageData = imageData
        dismiss(animated: true, completion: updateView)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func actionButtonTapped(_ sender: Any) {

        let image = furnitureImageView.image
        let title = furnitureTitleLabel.text
        let description = furnitureDescriptionLabel.text
        let content: [Any?] = [image, title, description]

        let activityController = UIActivityViewController(activityItems: content as [Any], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        activityController.title = furnitureTitleLabel.text
        activityController.tabBarItem.image = image
        present(activityController, animated: true, completion: nil)

    }
    

}
