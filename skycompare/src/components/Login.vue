<template>
    <v-sheet class="loginComponent">
      <span class="cerrar" @click="salir">X</span>
      <v-card class="cardComponent">
        <v-form v-model="form" @submit.prevent="onSubmit">
          <v-spacer class="blind">----------------</v-spacer>
          <v-text-field v-model="user" :readonly="loading" :rules="[required]" class="text" label="User"
            clearable color="#ff5e00"></v-text-field>

          <v-text-field v-model="password" :readonly="loading" :rules="[required]" label="Password"
            placeholder="Enter your password" clearable color="#ff5e00"></v-text-field>

          <br>

          <v-btn :disabled="form" :loading="loading" color="success" size="large" type="submit" variant="elevated"
            block>
            Login
          </v-btn>
          <v-spacer class="blind">----------------</v-spacer>
          <v-btn color="primary" size="large" variant="elevated" @click="register"
            block>
            Sing In
          </v-btn>
        </v-form>
      </v-card>
    </v-sheet>
</template>

<script>
import { VTextField, VForm, VBtn } from "vuetify/lib";
import { VSheet, VCard, VSpacer } from "vuetify/lib";

export default {
  name: 'LoginView',
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
    salir(){
      this.$emit("close");
    },
    register(){
      this.$emit("register");
    }
  }

  
}
</script>

<style scoped>
.loginComponent {
  width: 500px;
  height: 300px;
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
