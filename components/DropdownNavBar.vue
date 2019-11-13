<template>
  <div>
    <div class="flex">
      <div>
        <input type="radio" name="target" v-model="target" value="hover"/>
        hover
      </div>
      <div>
        <input type="radio" name="target" v-model="target" value="click"/>
        click
      </div>
    </div>
    <div class="flex justify-around text-center -mx-4">
      <div class="item w-full mx-4 relative" v-for="(i, k) in menus" :key="k" :class="{on: idx === k}"
           @mouseenter="itemMouseenter(k)" @mouseleave="itemMouseleave(k)">
        <nuxt-link class="trigger block py-3 bg-blue-200 w-full" :to="i.to" @click.native="itemClick(k)">
          {{ i.name }}
        </nuxt-link>
        <div class="child absolute left-0 w-full bg-yellow-200 opacity-75">
          <nuxt-link class="py-4 w-full block" v-for="(ii, kk) in i.child" :to="ii.to" :key="kk" @click.native="childClick">
            {{ ii.name }}
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import throttle from 'lodash/throttle'
// import debounce from 'lodash/debounce'

export default {
  data(){
    return {
      menus: [
        {
          name: 'm1',
          to: '/test1',
          child: [
            {
              name: 'c1',
              to: '/test1',
            }
          ],
        },
        {
          name: 'm2',
          to: '/test2',
          child: [
            {
              name: 'c2',
              to: '/test2',
            }
          ],
        }
      ],
      idx: -1,
      // target: 'click',
      target: 'hover',
    }
  },
  mounted(){
    this.target = 'ontouchstart' in window ? 'click' : 'hover'
  },
  methods:{
    itemMouseenter(idx){
      if(this.target !== 'hover' || this.idx === idx) return;
      this.itemSwitch(idx)
    },
    itemMouseleave(idx){
      if(this.target !== 'hover' || this.idx !== idx) return;
      this.itemSwitch(idx)
    },
    itemClick(idx){
      if(this.target !== 'click') return;
      console.log('itemClick', idx)
      this.itemSwitch(idx)
    },
    childClick(){
      console.log('childClick')
      this.idx = -1;
    },
    itemSwitch: throttle(function(idx){
      console.log('itemSwitch', idx)
      this.idx = this.idx === idx ? -1 : idx
    }, 200),
  }
}
</script>

<style lang="scss">
  .item{

    .child{
      display: none;
      margin-top: -10px;
    }

    &.on{
      .child{
        display: block;
      }
    }
  }
</style>
