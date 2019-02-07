
//
//  Character.swift
//  RickMoya
//
//  Created by any.pinheiro on 04/02/19.
//  Copyright © 2019 any.pinheiro. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func set(character: Character) {
        if let url = URL(string: character.Image){
            ivCharacter.kf.indicatorType = .activity
            ivCharacter.kf.setImage(with: url)
        }
        lbName.text = character.Name
        lbGender.text = character.Gender
    }
}

