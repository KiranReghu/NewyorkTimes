//
//  Utility.swift
//  NY Times
//
//  Created by Kiran R on 18/09/21.
//

import UIKit

public struct Utility {
    
    public func getStackView(axis: NSLayoutConstraint.Axis,
                              alignment: UIStackView.Alignment,
                              distribution: UIStackView.Distribution,
                              spacing: CGFloat) -> UIStackView {
        
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        
        return stackView
        
    }
    
    public func setStackViewPadding(_ stackView: UIStackView,
                                     top: CGFloat,
                                     leading: CGFloat,
                                     bottom: CGFloat,
                                     trailing: CGFloat) {
        
        stackView.isLayoutMarginsRelativeArrangement = true
        
        if #available(iOS 11.0, *) {
            
            stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing )
            
        } else {
            
            stackView.layoutMargins = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing )
            
        }
        
    }
    
    public func getRoundedView(_ size: CGFloat, radius: CGFloat) -> UIView {
        
        let roundedView = UIView(frame: .zero)
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.layer.cornerRadius = radius
        roundedView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
        
            roundedView.heightAnchor.constraint(equalToConstant: size),
            roundedView.widthAnchor.constraint(equalToConstant: size)
        
        ])
        
        return roundedView
        
    }
    
    public func getLabel(_ font: UIFont,
                          color: UIColor,
                          numberOfLines: Int = 0) -> UILabel {
        
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = color
        return label
        
    }
    
    public func getIconWithLabelView(_ font: UIFont,
                                      color: UIColor,
                                      iconName: String,
                                      labelName: String,
                                      size: CGFloat) -> UIStackView {
        
        let iconView = getIconView(name: iconName, size: size, color: color)
        let label = getLabel(font, color: color, numberOfLines: 1)
        label.text = labelName
        
        let stackView = getStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 2)
        
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(label)
        
        return stackView
        
    }
    
    public func getIconView(name: String,
                             size: CGFloat,
                             color: UIColor) -> UIView {
        
        let image = UIImage(named: name)!
        image.withTintColor(color)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.widthAnchor.constraint(equalToConstant: size)
        
        ])
       
        return imageView
        
    }
    
}

public enum NetworkErrors: Error {
    
    case wrongUrl
    case unKnownResponse
    case parseError
    
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
