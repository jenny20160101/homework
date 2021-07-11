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
import { defineComponent, reactive, computed, onMounted } from "vue";
// import HelloWorld from '@/components/HelloWorld.vue'; // @ is an alias to /src
import ItemsListComponent from "@/components/items/ItemsList.componet.vue";
import { ItemInterface } from "@/models/items/Item.interface";
import store from "@/store";

export default defineComponent({
  name: "Home",
  components: {
    // HelloWorld,
    ItemsListComponent,
  },
  setup() {
    // const items: ItemInterface[] = reactive([
    //   { id: 1, name: "Item 1", selected: false },
    //   { id: 2, name: "Item 2", selected: true },
    //   { id: 3, name: "Item 3", selected: false },
    // ]);

    const items = computed(() => {
      return store.state.items;
    });
    const loading = computed(()=>{
      return store.state.loading;
    });

    onMounted(()=>{
      store.dispatch("loadItems")
    });

  const onSelectItem = (item: ItemInterface)=>{
    store.dispatch("selectItem", {id: item.id,
    selected: !item.selected})
  }


    return { items, loading, onSelectItem };
  },
});
</script>
