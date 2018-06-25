import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoCategories: [PhotoCategory] = PhotoLibrary.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let showDetailViewController = "ShowImageDetail"
        
        // for the grid
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        // works along with min spacing set for collection view in storyboard
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCategories[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        return cell
    }
    
    // section header view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        
        let category = photoCategories[indexPath.section]
        sectionHeaderView.photoCategory = category
        
        return sectionHeaderView
    }
    
    //MARK: - UICollectionViewDelegate
    
    var selectedImage: UIImage!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        
        performSegue(withIdentifier: Storyboard.showDetailViewController, sender: nil)
 
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailViewController {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.image = selectedImage
        }
    }
    
    
}
