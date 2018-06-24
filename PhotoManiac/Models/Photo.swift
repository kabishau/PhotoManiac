import Foundation

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageNames: [String]
    
}

class PhotoLibrary {
    
    class func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photoData = PhotoLibrary.downloadPhotosData()
        
        for (categoryTitle, dictionary) in photoData {
            guard let dictionary = dictionary as? [String: Any],
                let categoryImageName = dictionary["categoryImageName"] as? String,
                let imageNames = dictionary["imageNames"] as? [String] else {
                    break
            }
            let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
            categories.append(newCategory)
        }
        
        return categories
    }
    
    class func downloadPhotosData() -> [String: Any] {
        return
            [
                "Family" : [
                    "categoryImageName" : "family",
                    "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "f", numberOfImages: 9),
                ],
                "Foods" : [
                    "categoryImageName" : "foods",
                    "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "fo", numberOfImages: 8),
                ],
                "Travel" : [
                    "categoryImageName" : "travel",
                    "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "t", numberOfImages: 9),
                ],
                "Nature" : [
                    "categoryImageName" : "nature",
                    "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "n", numberOfImages: 8),
                ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        return imageNames
    }
    
}
