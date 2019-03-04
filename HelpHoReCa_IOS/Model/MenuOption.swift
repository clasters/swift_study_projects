//
//  MenuOption.swift
//  HelpHoReCa_IOS
//
//  Created by Mark on 13/02/2019.
//  Copyright © 2019 Mark. All rights reserved.
//
import UIKit

enum MenuOption: Int, CustomStringConvertible{
    case Profile
    case Inbox
    case Notification
    case Settings
    
    var description: String {
        switch self {
        case .Profile: return "Профиль"
        case .Inbox: return "Главная"
        case .Notification: return "Уведомления"
        case .Settings: return "Настройки"
        }
    }
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .Inbox: return UIImage(named: "ic_mail_outline_white_2x") ?? UIImage()
        case .Notification: return UIImage(named: "ic_mail_outline_white_2x") ?? UIImage()
        case .Settings: return UIImage(named: "baseline_settings_white_24dp") ?? UIImage()
        }
    }
}
