<template>
  <div class="Welcome">
    <div>
      <img alt="Vue logo" src="../assets/logo.png" height="20%" width="20%" class="logo">
    </div>
    <div>
      <h1>Welcome to SkyCompare</h1>
      <p style="color: white;">by Jose Luis Viejo  & David Villar</p>
    </div>
    <button class="button1" @click="access"> Start</button>
  </div>
</template>

<script>
export default {
  name: 'StartView',
  methods:{
    access() {
      this.$router.push("/MainCompare");
    },
  }
}
</script>

<style scoped>
.Welcome{
  background-image: url("../assets/backgroundStart.jpg");
  position:absolute;
  top: 0vh;
  left: 0vw;
  width: 100vw;
  height: 100vh;
  text-align: center;
}

h1{
  margin-top: -5vh;
  color: white;
  font-size: 60px;
}

.logo{
  margin-top: 2vh;
  margin-left: -3vw;
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
  margin-top: 26vh;
}
</style>
