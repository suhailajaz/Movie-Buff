//
//  MovieCollectionViewCell.swift
//  Project-7-GetThoseMovies
//
//  Created by suhail on 20/09/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imgMovieIcon: UIImageView!
    @IBOutlet var lblMovieYear: UILabel!
    @IBOutlet var lblImageName: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    static func nib()->UINib{
        return UINib(nibName:"MovieCollectionViewCell" , bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
      
    
    }
    func configure(with model: Search){
        self.lblImageName.text = model.Title
        self.lblMovieYear.text = model.Year
        
        let moviePosterURLString = model.Poster
        DispatchQueue.global(qos: .background).async {
            if let imageData = try? Data(contentsOf: URL(string: moviePosterURLString)!){
            
                DispatchQueue.main.async {
                    self.imgMovieIcon.image = UIImage(data: imageData)
                    
                }
            }
            
        }
       
        
        
        
    }

}
