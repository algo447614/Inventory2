import SwiftUI

struct CheckBoxView: View {
    @State private var isChecked: Bool
    var item: Item
    var profile: Profile
    var category: Category
    @ObservedObject var appLogic: AppLogic

    init(item: Item, profile: Profile, category: Category, appLogic: AppLogic) {
        self.item = item
        self.profile = profile
        self.category = category
        self.appLogic = appLogic
        self._isChecked = State(initialValue: !item.needsToBuy)
    }

    var body: some View {
        Button(action: {
            isChecked.toggle()
            item.needsToBuy = !isChecked
            saveChanges()
        }) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .foregroundColor(isChecked ? .green : .red)
        }
    }

    private func saveChanges() {
        let newItem = Item(name: item.name, price: item.price, link: item.link, customImage: item.customImage, needsToBuy: item.needsToBuy, storeTag: item.storeTag)
        appLogic.editItem(in: category.name, of: profile.name, oldItemName: item.name, newItem: newItem)
    }
}
