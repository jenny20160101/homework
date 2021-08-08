import {rootStore, dispatchModuleAction} from "../root";
import {StoreModuleNames, ItemsStateInterface} from "@/models/store";

const itemsStore = {
    get state(): ItemsStateInterface {
        return rootStore.state.itemState
    },
    action<T>(actionName: string, params?: T): void {
        dispatchModuleAction(StoreModuleNames.itemsState, actionName, params)
    }
}
// export our wrapper using the composition API convention (i.e. useXYZ)
export const useItemsStore = () => {
    return itemsStore
}