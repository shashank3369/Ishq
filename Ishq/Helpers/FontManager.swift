//
//  FontManager.swift
//  Ishq
//
//  Created by Sishir Mohan on 3/5/23.
//

import Foundation
import UIKit
import SwiftUI

extension Font {
    static var PoppinsTitle: Font {
        Font.custom("Poppins-Regular", size: 32, relativeTo: .title)
        }
    static var PoppinsTitle2: Font {
        Font.custom("Poppins-Regular", size: 20, relativeTo: .title2)
        }
    static var PoppinsTitle3: Font {
        Font.custom("Poppins-Regular", size: 16, relativeTo: .title3)
        }
    static var PoppinsBody: Font {
        Font.custom("Poppins-Regular", size: 14, relativeTo: .body)
        }
    
    static var InterTitle: Font {
        Font.custom("Inter-Regular", size: 32, relativeTo: .title)
        }
    static var InterTitle2: Font {
        Font.custom("Inter-Regular", size: 20, relativeTo: .title2)
        }
    static var InterTitle3: Font {
        Font.custom("Inter-Regular", size: 16, relativeTo: .title3)
        }
    static var InterBody: Font {
        Font.custom("Inter-Regular", size: 14, relativeTo: .body)
        }
    static var BaskervilleTitle: Font {
        Font.custom("LibreBaskerville-Regular", size: 32, relativeTo: .title)
        }
    static var BaskervilleTitle2: Font {
        Font.custom("LibreBaskerville-Regular", size: 20, relativeTo: .title2)
        }
    static var BaskervilleTitle3: Font {
        Font.custom("LibreBaskerville-Regular", size: 16, relativeTo: .title3)
        }
    static var BaskervilleBody: Font {
        Font.custom("LibreBaskerville-Regular", size: 14, relativeTo: .body)
        }
    static var BaskerVilleItalicTitle: Font {
        Font.custom("LibreBaskerville-Italic", size: 32, relativeTo: .title)
    }
    static var BaskerVilleItalicBody: Font {
        Font.custom("LibreBaskerville-Italic", size: 20, relativeTo: .title)
    }
    
    
}
