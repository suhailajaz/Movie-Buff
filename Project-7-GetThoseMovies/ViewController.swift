//
//  ViewController.swift
//  Project-7-GetThoseMovies
//
//  Created by suhail on 20/09/23.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    var movies = [Search]()
   
    @IBOutlet var col: UICollectionView!{
        didSet{
            self.col.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        }
    }
    @IBOutlet var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        col.delegate = self
        col.dataSource = self
        txtSearch.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    func searchMovies(){
        txtSearch.resignFirstResponder()
        guard var text = txtSearch.text, !text.isEmpty else { return }
        movies.removeAll()
        text = text.replacingOccurrences(of: " ", with: "%20")
       
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(text)&type=movie") else{
            print("Invalid URL")
            txtSearch.text = ""
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            //
            var result: Movies?
            do{
                result = try JSONDecoder().decode(Movies.self, from: data)
            }catch{
                print("parsing error: \(error)")
            }
            guard let newMovies = result?.Search else { return }
            self.movies.append(contentsOf: newMovies)
            DispatchQueue.main.async{
                self.col.reloadData()
            }
        
        }.resume()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (col.bounds.width/2)-15, height: (col.bounds.width/2)-15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
         let vc = storyboard?.instantiateViewController(withIdentifier: "webbVC") as! WebViewController
            vc.site = movies[indexPath.row].imdbID
        vc.movieName = movies[indexPath.row].Title
            navigationController?.pushViewController(vc, animated: true)
        
    }
}

