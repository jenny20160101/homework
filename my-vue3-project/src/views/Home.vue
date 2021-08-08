<template>
  <div class="home">
    <ItemsListComponent
      :items="items"
      :loading="loading"
      @selectItem="onSelectItem"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent,  computed, onMounted } from "vue";
// import HelloWorld from '@/components/HelloWorld.vue'; // @ is an alias to /src
import ItemsListComponent from "@/components/items/ItemsList.componet.vue";
import { ItemInterface } from "@/models/items/Item.interface";
// import store from "@/store";
import {rootStore} from "@/store";
import {MutationType, StoreModuleNames} from "@/models/store";
import {useItemsStore} from "@/store/items";

export default defineComponent({
  name: "Home",
  components: {
    // HelloWorld,
    ItemsListComponent,
  },
  setup() {
    const itemsStore=useItemsStore()



    const items = computed(() => {
      // return store.state.items;
      return itemsStore.state.items;
    });
    const loading = computed(()=>{
      // return store.state.loading;
      return itemsStore.state.loading;
    });

    onMounted(()=>{
      // store.dispatch(MutationType.items.loadItems)
      // store.dispatch(`${StoreModuleNames.itemsState}/${MutationType.items}`)
      itemsStore.action(MutationType.items.loadItems)
    });

  const onSelectItem = (item: ItemInterface)=>{
    // store.dispatch("selectItem", {id: item.id,
    // selected: !item.selected})

    // store.dispatch(`${StoreModuleNames.itemsState}/${MutationType.items}`,{id: item.id,
    //   selected: !item.selected})

    itemsStore.action(MutationType.items.selectItem, {id: item.id,
      selected: !item.selected})
  }


    return { items, loading, onSelectItem };
  },
});
</script>
