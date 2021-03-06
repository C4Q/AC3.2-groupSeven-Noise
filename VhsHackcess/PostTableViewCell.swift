//
//  PostTableViewCell.swift
//  VhsHackcess
//
//  Created by Victor Zhong on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicHeadline: UILabel!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var user: String? {
        didSet {
            if let email = user {
                setupStringLabel(email)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topicHeadline.textColor = ColorManager.shared.primary
    }
    
    fileprivate func setupStringLabel(_ user: String) {
        
        let attributedString = NSMutableAttributedString(string: "Submitted by: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)])
        let descriptionAttribute = NSMutableAttributedString(string: user, attributes: [NSForegroundColorAttributeName : ColorManager.shared.primary, NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)])
        attributedString.append(descriptionAttribute)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let textLength = attributedString.string.characters.count
        let range = NSRange(location: 0, length: textLength)
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        infoLabel.attributedText = attributedString
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
