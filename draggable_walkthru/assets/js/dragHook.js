import Sortable from 'sortablejs';


export default {

  mounted() {

    /* implementation will go here */

    let dragged; // this will change so we use `let`

    const hook = this;

    const selector = '#' + this.el.id;

     console.log('The selector is:', selector);

     document.querySelectorAll('.dropzone').forEach((dropzone) => {

           /* implementation to make this sortable will go here */

         });
  }

};