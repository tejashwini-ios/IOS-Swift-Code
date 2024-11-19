//
//  FlickerGridViewModel.swift
//  FlickerGridDemo
//
//

import Foundation

class FlickerGridViewModel: ObservableObject {
    
    @Published var items: [FlickerModel] = []
    @Published var searchText: String = "Flower" {
        didSet {
            guard !searchText.isEmpty else { return }
            Task {
                await self.fetchItems()
            }
        }
    }
    private var apiClient = FlickerAPI()
    init() {
        Task {
            await fetchItems()
        }
    }
    var filtereItem: [FlickerModel] {
        return items
    }
    func fetchItems() async {
        do {
            guard let fetchedItems = try await apiClient.fetchFlickerList(text: searchText) else {
                return
            }
            DispatchQueue.main.async {
                self.items = fetchedItems.items
            }
        } catch {
            print("Failed to get flicker list: \(error)")
        }
    }
}
