import {Module, MutationTree, ActionTree, GetterTree} from "vuex";

import {MutationType, RootStateInterface, ItemsStateInterface} from "@/models/store";
import {initialItemsState} from "./initialState";
import {ItemInterface} from "@/models/items/Item.interface";
import apiClient from "@/api-client";

export const mutations:
    MutationTree<ItemsStateInterface> = {
        loadingItems(state: ItemsStateInterface) {
            state.loading = true
        },
        loadedItems(state: ItemsStateInterface, items: ItemInterface[]) {
            state.items = items
            state.loading = false
        },
        selectItems(state: ItemsStateInterface, param: {
            id: number
            selected: boolean
        }) {
            const {id, selected} = param
            const item = state.items.find(o => o.id === id)
            if (item) {
                item.selected = selected
            }
        }
}

export const actions: ActionTree<ItemsStateInterface, RootStateInterface> = {
    loadItems({commit}) {
        commit(MutationType.items.loadingItems)

        setTimeout(() => {
            apiClient.items.fetchItems().then((data: ItemInterface[]) => {
                commit(MutationType.items.loadItems, data)
            })
        }, 1000)
    },
    selectItem({commit}, params: {
        id: number
        selected: boolean
    }) {
        commit(MutationType.items.selectItem, params)
    }
}

export const getters: GetterTree<ItemsStateInterface, RootStateInterface> = {}

const namespaced: boolean = true
const state: ItemsStateInterface = initialItemsState

export const itemsState: Module<ItemsStateInterface, RootStateInterface> = {
    namespaced, state, getters, actions, mutations
}

