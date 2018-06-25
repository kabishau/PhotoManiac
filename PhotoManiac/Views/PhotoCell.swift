import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageName: String = "" {
        didSet {
            photoImageView.image = UIImage(named: imageName)
        }
    }
}
