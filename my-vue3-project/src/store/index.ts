import { createStore } from 'vuex'
import { ItemInterface } from "@/models/items/Item.interface"
import { ItemsStateInterface } from "@/models/store/ItemsState.interface"
import apiClient  from "@/api-client"

const state: ItemsStateInterface = {
  loading: false,
  items: []
}

export default createStore({
  state: state,
  mutations: {
    loadingItems(state: ItemsStateInterface) {
      state.loading = true
      state.items = []
    },
    loadedItems(state: ItemsStateInterface, items: ItemInterface[]) {
      state.loading = false
      state.items = items
    },
    selectItem(state: ItemsStateInterface, params:{id: number, selected: boolean}){
      const {id, selected} = params
      const item = state.items.find(o=>o.id===id)
      if(item){
        item.selected = selected
      }
    }
  },
  actions: {
    loadItems({ commit, state }) {
      commit("loadingItems")

      // // mock data
      // const mockItems: ItemInterface[] = [
      //   { id: 1, name: "Item 1", selected: false },
      //   { id: 2, name: "Item 2", selected: true },
      //   { id: 3, name: "Item 3", selected: false },
      // ]

      setTimeout(() => {
        // commit("loadedItems", mockItems)
        apiClient.items.fetchItems().then((data: ItemInterface[])=>{
          commit("loadedItems", data)
        })
      }, 1000)

    },

    selectItem({ commit}, params:{id: number, selected: boolean}){
      commit("selectItem", params)
    }
  },
  modules: {
  }
})
