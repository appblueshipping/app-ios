//
//  SWUtils.swift
//  user
//
//  Created by Adson Nascimento on 26/01/17.
//  Copyright © 2017 PIPz. All rights reserved.
//


import Foundation
import UIKit
import SystemConfiguration

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

enum DeviceType:Int {
    case IPHONE_DEVICE = 1
    case IPAD_DEVICE   = 2
}

enum DeviceBoundsSizeHeight:CGFloat{
    case IPHONE6PLUS_HEIGHT = 736.0
    case IPHONE6_HEIGHT = 667.0
    case IPHONE5_HEIGHT = 586.0
    case IPHONE4_HEIGHT = 480.0
}

enum DeviceBoundsSizeWidth: CGFloat {
    case IPHONE4OR5_HEIGHT =  320.0
    case IPHONE6_HEIGHT     = 375.0
    case IPHONE6PLUS_WIDTH =  414.0
}

class SWUtils: NSObject {
    
    // Real ScreeSize
    static let screenSizeHeight = UIScreen.main.bounds.height
    static let screenSizeWidth = UIScreen.main.bounds.width
    
    static let USER_PLATAFORM_IOS   = 2
    static let USER_DEVICE_ID       = UIDevice.current.identifierForVendor!.uuidString
    static let APP_VERSION          = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    static let DEVICE_MODEL_NAME    = UIDevice.current.modelName
    static let DEVICE_IOS_VERSION   = UIDevice.current.systemVersion
    
    static let networErrorTitle     = "Sem acesso à internet"
    static let networErrorMessage   = "Conecte-se à internet e tente novamente."
    static let serverErrorTitle     = "Sem acesso ao servidor"
    static let serverErrorMessage   = "Error ao acessar o servidor. Tente novamente mais tarde."
    
    static let googleMapsAPIErrorTitle     = "Falha ao busca localização"
    static let googleMapsAPIErrorMessage   = "Falha ao busca sua localização. Tente novamente mais tarde."
    
    static var currentDeviceType:Int{
        if UIDevice.current.model == "iPhone" || UIDevice.current.model == "iPhone Simulator"{
            return  DeviceType.IPHONE_DEVICE.rawValue
        }else if UIDevice.current.model == "iPad"  || UIDevice.current.model == "iPad Simulator" {
            return DeviceType.IPAD_DEVICE.rawValue
        }
        return 0
    }

    //Current Language
    static func getDeviceLanguage() -> String {
        let currentLanguageString = Bundle.main.preferredLocalizations.first
        if (currentLanguageString != nil ) && (currentLanguageString == "pt" || currentLanguageString == "pt-BR" || currentLanguageString!.contains("pt")){
            return "pt"
        }else {
            return "en"
        }
    }
    
    static func checkNetworkConnection() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
		
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    static func isPushEnabled(controller:UIViewController?)->Bool{
		
        let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
        if notificationType == []  {
            
            if controller != nil{
                
                // Push notifications are disabled in setting by user.
                let alertController = UIAlertController(title: "Notificações Desabilitadas", message: "Para realizar um pedido você precisa permitir o recebimento de notificações.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Abrir Configurações", style: .cancel, handler: { (_) -> Void in
                    
                    if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                }))
                alertController.addAction(UIAlertAction(title: "Agora Não", style: UIAlertActionStyle.default , handler: nil))
                controller!.present(alertController, animated: true, completion: nil)
                
            }
            
            return false
            
        }else{
            
            return true
        }
    }
    
//    //MARK: - Crop Image for send to server
//    static func squareCropImageToSideLength(let sourceImage: UIImage,
//                                                let sideLength: CGFloat) -> UIImage {
//        // input size comes from image
//        let inputSize: CGSize = sourceImage.size
//        
//        // round up side length to avoid fractional output size
//        let sideLength: CGFloat = ceil(sideLength)
//        
//        // output size has sideLength for both dimensions
//        let outputSize: CGSize = CGSizeMake(sideLength, sideLength)
//        
//        // calculate scale so that smaller dimension fits sideLength
//        let scale: CGFloat = max(sideLength / inputSize.width,
//                                 sideLength / inputSize.height)
//        
//        // scaling the image with this scale results in this output size
//        let scaledInputSize: CGSize = CGSizeMake(inputSize.width * scale,
//                                                 inputSize.height * scale)
//        
//        // determine point in center of "canvas"
//        let center: CGPoint = CGPointMake(outputSize.width/2.0,
//                                          outputSize.height/2.0)
//        
//        // calculate drawing rect relative to output Size
//        let outputRect: CGRect = CGRectMake(center.x - scaledInputSize.width/2.0,
//                                            center.y - scaledInputSize.height/2.0,
//                                            scaledInputSize.width,
//                                            scaledInputSize.height)
//        
//        // begin a new bitmap context, scale 0 takes display scale
//        UIGraphicsBeginImageContextWithOptions(outputSize, true, 0)
//        
//        // optional: set the interpolation quality.
//        // For this you need to grab the underlying CGContext
//        let ctx: CGContextRef = UIGraphicsGetCurrentContext()!
//        CGContextSetInterpolationQuality(ctx, CGInterpolationQuality.High)
//        
//        // draw the source image into the calculated rect
//        sourceImage.drawInRect(outputRect)
//        
//        // create new image from bitmap context
//        let outImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        // clean up
//        UIGraphicsEndImageContext()
//        
//        // pass back new image
//        return outImage
//    }
	
}
