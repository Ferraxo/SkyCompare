<template>
    <div class="Login">
        <v-sheet class="loginComponent" v-show="loginShow">
        <span class="cerrar" @click="salir">X</span>
        <v-card class="cardComponent">
            <v-form @submit.prevent="onSubmit">
            <v-spacer class="blind">----------------</v-spacer>
            <v-text-field 
              ref="nickname"
              v-model="nickname" 
              class="text" 
              label="Nickname*" 
              placeholder="Write your nickname" 
              clearable color="#ff5e00"
            ></v-text-field>


            <v-text-field 
              ref="password"
              v-model="password" 
              label="Password*"
              placeholder="Enter your password" 
              clearable color="#ff5e00"
              type="password"
            ></v-text-field>
            <br>

            <v-btn color="success" size="large" type="submit" variant="elevated"
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
        <RegisterView v-show="registerShow" @close="closeRegister" @closeWindow="closeRegister" class="register"/>
    </div>
</template>

<script>
import axios from "axios";
import { VTextField, VForm, VBtn } from "vuetify/lib";
import { VSheet, VCard, VSpacer } from "vuetify/lib";
import RegisterView from '@/components/Register.vue';

export default {
  name: 'LoginView',
  components: {
    VSheet,
    VCard,
    VTextField,
    VForm,
    VBtn,
    VSpacer,
    RegisterView,
  },
  data:()=>({
      registerShow: false,
      loginShow: true,
      nickname: "",
      password: "",
  }),
  methods:{
    salir(){
      this.$router.push("/MainCompare");
    },
    closeLog(){
      alert("patata");
      this.$emit("closeLog");
    },
    register(){
      this.loginShow=false
      this.registerShow=true;
    },
    closeRegister(){
      this.registerShow=false;
      this.loginShow=true;
    },
    async onSubmit(){
      var out = 0;

      if(this.nickname=="This field is required") this.nickname="";
      if(this.password=="This field is required") this.password="";
      if(this.nickname=="" || this.password==""){
        if(this.nickname=="") this.nickname="This field is required"
        if(this.password=="") this.password="This field is required"
      }
      else{
        await axios.get("http://localhost:5152/login", {
          params: {
            nickname: this.nickname,
            password: this.password,
          }
        }).then(res => {
          console.log(res);
          if(res.data=="ok"){
            out = 1;
          }else{
            alert(res.data);
          }
        })

        if(out==1){
          sessionStorage.setItem("user", this.nickname);
          this.$router.push("/MainCompare");
        }
      }
    }
  }
}
</script>

<style scoped>
.Login{
  background-image: url("../assets/image1.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  position:absolute;
  top: 0vh;
  left: 0vw;
  width: 100vw;
  height: 100vh;
}

.loginComponent {
  position: absolute;
  margin-top: 15%;
  margin-left: 30%;
  width: 500px;
  height: 300px;
  border-style: solid;
  border-width: 5px;
  border-color: #ff5e00;
  border-radius: 25px;
  background: #90a0bf;
}

.register{
  position:absolute;
  margin-top: 7%;
  margin-left: 30%;
  height: 72vh;
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
