<script setup>
import {ref} from "vue";

const items = ref([])
const socket = new WebSocket("ws://localhost:9100")
const sendMessage = (event) => {
  socket.send("ok")
  console.log("send to websocket")
}

socket.onmessage = (event) => {
  console.log("onmessage: ", event.data)
  addItem(event.data)
}


const list = ref([]);


const addItem = (data) => {
  list.value.push({message:data});
};


</script>

<template>
  <div class="chat-container">
    <!-- Name Input window -->
    <div>
      <div class="modal-background">
        <div class="modal-content">
          <form @submit.prevent="handleSubmit" style="text-align: center;">
            <h3> Counter </h3>
            <h3> 1 </h3>
            <br>
            <button type="submit" @click="sendMessage"> Connect</button>
          </form>
        </div>
      </div>
    </div>
    <br/>
    <div  style="width: 400px; height: 600px; border: 1px solid black; text-align: center;">
      <p v-for="item in list">
        {{item.message}}
      </p>
    </div>
  </div>

</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>
