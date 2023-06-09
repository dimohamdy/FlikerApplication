//
//  ListViewModelState.swift
//  Monjasa
//
//  Created by Karim Ihab on 09/03/2022.
//

enum ListViewModelState<T: Any> {
	case loading
    case loaded(data: [T])
    case error(error: String)
    case placeholder

    func isLoading() -> Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
