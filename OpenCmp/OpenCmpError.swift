
import Foundation

enum CmpError {
    case uiError(type: Enums.NetworkError)
    case loadingHtml(errorDescription: String?)

    class Enums { }
}

extension CmpError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .uiError(let type): return type.localizedDescription
            case .loadingHtml(let errorDescription): return errorDescription
        }
    }
}


extension CmpError.Enums {
    enum NetworkError {
        case showUiError
        case hideUiError
        case cmpLoadingError(errorDescription: String?)
    }
}

extension CmpError.Enums.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .showUiError: return "showUiError"
            case .hideUiError: return "hideUiError"
            case .cmpLoadingError(let errorDescription): return errorDescription
        }
    }
}


class CmpErrorReader {
    static let shared = CmpErrorReader()
    private init() {}
    
     func handleError(_ err: Error) {
        switch err {
            case is CmpError:
                switch err as! CmpError {
                case .loadingHtml (let type):
                    print("CMP loadingHtml ERROR, \(type)")
                case .uiError(let type):
                    print("uiError, \(type)")
                }
            default: print(err)
        }
    }
}
