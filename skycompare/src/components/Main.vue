<template>
  <div class="Main">

    <div class="menu">
      <img alt="Vue logo" src="../assets/logo.png" height="100%" width="5%" class="logoMain">
      <span>SkyCompare®</span>
      <nav>
      </nav>
      <p id="login" @click="login">Login</p>
    </div>
    <LoginView v-show="loginShow" @close="closeLogin" @register="registerForm" class="login"/>
    <RegisterView v-show="registerShow" @close="closeRegister" class="register"/>
  </div>
</template>

<script>
import LoginView from "@/components/Login.vue"
import RegisterView from "@/components/Register.vue"
export default {
  name: 'MainComponent',
  components:{
    LoginView,
    RegisterView,
  },
  data:()=>({
    loginShow: false,
    registerShow: false,
  }),
  methods:{
    login(){
      this.loginShow=true;
    },
    closeLogin(){
      this.loginShow=false;
    },
    registerForm(){
      this.loginShow=false;
      this.registerShow=true;
    },
    closeRegister(){
      this.registerShow=false;
      this.loginShow=true;
    }
  }
}
</script>

<style scoped>
.Main{
  background-image: url("../assets/image1.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  position:absolute;
  top: 0vh;
  left: 0vw;
  width: 100vw;
  height: 100vh;
}

.menu{
  position: absolute;
  margin-top: 0vh;
  color: white;
  background-color: #90a0bf;
  width: 100%;
  height: 7.2vh;
  font-size: 60px;
  display: flex;
  padding-left: 20%;
  font-size: 10px;
}

span{
  position: absolute;
  left: 7vw;
  top: 0vh;
  font-size: 25px;
  font-weight: bold;
}

p{
  position:absolute;
  right: 10vw;
  margin-top: 0.5vh;
  font-size: 25px;
}

p:hover{
  color: #ff5e00;
  border-style: solid;
  border-radius: 10px;
  border-color: #ff5e00;
  margin-top: 0.3vh;
  right: 9.85vw;
}

.logoMain{
  margin-top: 0.5vh;
  margin-left: -18vw;
}

.button1{
  height: 100px;
  width: 200px;
  font-size: 40px;
  background-color: black;
  color: cyan;
  border-style: solid;
  border-width: 6px;
  border-color: cyan;
  border-radius: 30px;
}

.login{
  position: absolute;
  margin-top: 15%;
  margin-left: 30%;
}

.register{
  position:absolute;
  margin-top: 7%;
  margin-left: 30%;
}
</style>
