import Vue from 'vue'
import VueRouter from 'vue-router'
import WelcomeView from '../components/Start.vue'
import LoginView from '../views/Login.vue'
import MainView from '../views/Main.vue'
//import { component } from 'vue/types/umd'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: WelcomeView
  },
  {
    path: '/Login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/MainCompare',
    name: 'compare',
    component: MainView

  },

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
