<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'

const socket = new WebSocket('ws://localhost:9200')

const handleConnect = () => {
  if(username.value.length > 0) {
    connect.value = true
  }
}

const sendMessage = (event) => {
  console.log("send to websocket")
        socket.send("ok")
      }

      socket.onmessage = (event) => {
        console.log("onmessage: ", event.data)
        
      }

  //     socket.onclose = function(e) {
  //   console.log('Socket is closed. Reconnect will be attempted in 1 second.', e.reason);
  //   setTimeout(function() {
  //      socket = new WebSocket('ws://localhost:9100')
  //   }, 100);
  // };

  // socket.onerror = function(err) {
  //   console.error('Socket encountered error: ', err.message, 'Closing socket');
  //   socket.close();
  // };

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
              <!-- <input type="text" v-model="username" placeholder="Enter your name" /> -->
              <br>
              <button type="submit" @click="sendMessage"> Connect </button>
            </form>
          </div>
        </div>
      </div>
      <br/>
    <div style="width: 400px; height: 600px; border: 1px solid black; text-align: center;">
      History Goes Down Here !
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
