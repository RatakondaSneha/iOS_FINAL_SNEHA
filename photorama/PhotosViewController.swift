//
//  PhotosViewController.swift
//  photorama
//
//  Created by Joshua Vandermost on 2020-03-23.
//  Copyright © 2020 Joshua Vandermost. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    var imagesArray = [Photo]()
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatePhotos()
        

        store.fetchInterestingPhotos{
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
          
                self.updatePhotos()
                if let indexPhoto = self.imagesArray.first {
                    self.updateImageView(for: indexPhoto)
                }            case let .failure(error):
                print("Error fatching interesting photos: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func nextPhoto(_ sender: UITapGestureRecognizer) {
        
        index += 1
        self.updateImageView(for: imagesArray[index])
    }
    
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
    func updatePhotos(){
        store.fetchAllPhotos{
            (photosResult) -> Void in
            switch photosResult {
            case let .success(imagesArray):
                self.imagesArray = imagesArray
            case let .failure(error):
                print("There is an error while fetching the images from database")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
