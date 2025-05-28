<template>
  <div class="Main">

    <div class="menu">
      <img alt="Vue logo" src="../assets/logo.png" height="100%" width="5%" class="logoMain" @click="goBack">
      <span @click="goBack">SkyCompare®</span>
      <nav class="navigator">
        <v-btn class="vbtn" :disabled="!user">Save comparison</v-btn>
        <v-btn class="vbtn" :disabled="!user">Set favourite airport</v-btn>
      </nav>
      <p id="login" @click="login" v-show="showLogin">Login</p>
      <p class="user" v-show="!showLogin" @click="closeSession">{{ nickname }}</p>
    </div>
    <v-card class="selects">
      <v-select :items="airports" class="airfield" label="Departure Airport"></v-select>
      <v-btn class="goBtn">GO</v-btn>
      <v-select :items="airports" class="airfield" label="Arrival Airport"></v-select>

    </v-card>
    <Confirm :question="peticion" v-show="showConfirm" @close="closePeticion"/>
  </div>
</template>

<script>
import Confirm from "@/components/Confirm.vue";
import {VBtn, VCard, VSelect} from "vuetify/lib";
import axios from "axios";

export default {
  name: 'MainComponent',
  components:{
    Confirm,
    VBtn,
    VCard,
    VSelect,
  },  
  data:()=>({
    showLogin: true,
    showConfirm: false,
    nickname: "",
    peticion: "",
    airports: [],
    user: false,
  }),
  mounted(){
    const user = sessionStorage.getItem("user");
    if(user!=null && user!=""){
      this.nickname = user;
      this.showLogin=false;
      this.user = true;
    }
    this.getAirports();
  },  
  methods:{
    goBack(){
      this.$router.push("/");
    },  
    login(){
      this.$router.push("/Login");
    },
    closeSession(){
      this.peticion="Do you really want close your session";
      this.showConfirm=true;
    },
    closePeticion(code){
      this.showConfirm=false;
      if(code==0){
        this.showLogin=true;
        sessionStorage.removeItem("user");
        this.user=false;
      }
    },
    getAirports(){
      var airp = [];
      axios.get("http://localhost:5152/airports").then(r=>{
        console.log(r.data[0].IATA + " " + r.data.length);
        for(var i=0; i<r.data.length; i++){
          console.log(r.data[i].IATA);
          var string = r.data[i].IATA;
          airp.push(string);
        }
        console.log(airp)
        this.airports = airp;
        console.log(this.airports);
      });
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

.navigator{
  margin-left: 30vw;
  padding-top: 5px;
}

.vbtn{
  margin-left: 10px;
  border-style: solid;
  border-color: #ff5e00;
  border-radius: 15px;
}

.selects{
  margin-top: 60px;
  display: flex;
  width: 70vw;
  margin-left: 15vw;
  border-style: solid;
  border-color: #ff5e00;
  border-radius: 15px;
  border-width: 3px;
}

.airfield{
  margin-left: 8vw;
  padding-right: 8vw;
}

.goBtn{
  margin-top: 15px;
  border-style: solid;
  border-color: #ff5e00;
  border-radius: 15px;
}

</style>
