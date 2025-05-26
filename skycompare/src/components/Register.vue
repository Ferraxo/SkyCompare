<template>
    <v-sheet class="loginComponent">
      <span class="cerrar" @click="exit">X</span>
      <v-card class="cardComponent">
        <v-form v-model="form" @submit.prevent="onSubmit">
          <v-spacer class="blind">----------------</v-spacer>
          <v-text-field v-model="nickname" :readonly="loading" :rules="[required]" class="text" label="Nickname"
            placeholder="Write your nickname" clearable color="#ff5e00"></v-text-field>

          <v-text-field v-model="name" :readonly="loading" :rules="[required]" class="text" label="Full name"
            placeholder="Write your real name (blind)" clearable color="#ff5e00"></v-text-field>

          <v-text-field v-model="email" :readonly="loading" :rules="[required]" class="text" label="Email"
            placeholder="Write your email" clearable color="#ff5e00"></v-text-field>

          <v-text-field v-model="password" :readonly="loading" :rules="[required]" label="Password"
            placeholder="Write your password" clearable color="#ff5e00"></v-text-field>

          <v-text-field v-model="password2" :readonly="loading" :rules="[required]" label="Repeat password"
            placeholder="Repeat your password" clearable color="#ff5e00"></v-text-field>

          <br>

          <v-btn :disabled="!form" :loading="loading" color="success" size="large" type="submit" variant="elevated" @click="exit"
            block>
            Accept
          </v-btn>
        </v-form>
      </v-card>
    </v-sheet>
</template>

<script setup>
  import { ref } from 'vue';
  import axios from "axios";

  const form = ref(false)
  const nickname =ref(null)
  const name = ref(null)
  const email = ref(null)
  const password = ref(null)
  const password2 = ref(null)
  const loading = ref(false)

  async function onSubmit(){
    var out = 0;
    if (!form.value) return;
    loading.value = true;
    setTimeout(() => (loading.value = false), 2000);
    if(password.value == password2.value){
      await axios.get("http://localhost:5152/register", {
        params: {
          nickname: nickname.value,
          full_name: name.value,
          email: email.value,
          password: password.value,
        }
      }).then(res => {
        alert(res.data);
        out = 1;
      })
    }else{
      alert("Both password are differents");
    }

    if(out==1){
      
      let event = new Event("close");
      this.dispatchEvent(event);

    }
  }

  function required(v) {
    return !!v || 'Field is required';
  }
</script>

<script>
import { VTextField, VForm, VBtn } from "vuetify/lib";
import { VSheet, VCard, VSpacer } from "vuetify/lib";

export default {
  name: 'RegisterView',
  components: {
    VSheet,
    VCard,
    VTextField,
    VForm,
    VBtn,
    VSpacer
  },
  data:()=>({
    
  }),
  methods:{
    exit(){
      alert("chivato");
      this.$emit("close");
    },
  },
}
</script>

<style scoped>
.loginComponent {
  width: 500px;
  height: 500px;
  border-style: solid;
  border-width: 5px;
  border-color: #ff5e00;
  border-radius: 25px;
  background: #90a0bf;
}

.cardComponent{
  background: #c8ddff;
  height: 100%;
  margin-top: 0%;
  margin-left: 0px;
  max-width:100%;
  padding: 10px;
  border-radius: 20px;
}

.cerrar{
  position: absolute;
  background: "#c8ddff";
  color: #ff5e00;
  font-size: 25px;
  z-index: 100;
  width: 38px;
  padding-left: 11px;
  border-radius: 25px;
  right: 5px;
  top: 5px;
}

.cerrar:hover{
  background: #ff5e00;
  color: white;
}

.blind{
  color: #c8ddff; 
  font-size: 10px;
}

</style>
