<template>
  <div>
    <h3>My Items:</h3>
    <h3>Items - loading: {{loading}}</h3>
    <Loader v-show="loading"></Loader>
    <ul v-show="!loading">
      <ItemComponent
        v-for="item in items"
        :key="item.id"
        :model="item"
        @select="onItemSelect"
      ></ItemComponent>
    </ul>
  </div>
</template>
<script lang="ts">
import { defineComponent, PropType } from "vue";
import { ItemInterface } from "@/models/items/Item.interface";
import ItemComponent from "./children/Item.component.vue";
import Loader from "@/components/shared/Loader.component.vue";

export default defineComponent({
  components: { ItemComponent, Loader },
  props: {
    items: {
      type: Array as PropType<ItemInterface[]>,
    },
    loading: { type: Boolean },
  },
  setup() {
    const onItemSelect = (item: ItemInterface) => {
      item.selected = !item.selected;
      console.log("onItemSelect", item.id, item.selected);
    };
    return { onItemSelect };
  },
});
</script>
<style lang="scss">
ul {
  list-style-type: none;
  margin-block-start: 0;
  margin-block-end: 0;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
  padding-inline-start: 0px;
}
</style>