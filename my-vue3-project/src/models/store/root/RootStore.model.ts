import Vuex from "vuex"
import {RootStoreInterface} from "@/models/store/root/RootStore.interface";

export class RootStoreModel<S> extends Vuex.Store<RootStoreInterface> {
}