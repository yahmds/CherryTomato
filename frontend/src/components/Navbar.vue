<template>
  <div>
    <nav>
      <div class="title">
        <a href="#">
          <router-link to="/" exact>
            <img src="../assets/images/panadoura.png" alt="logo" id="logo">
          </router-link>
        </a>
      </div>

      <label for="toggle">&#9776;</label>
      <input type="checkbox" id="toggle">

      <div class="menu">
        <router-link to="/login" v-show="!state.isAuthenticated" exact>
          <svg><use xlink:href="#twitter"></use></svg>
          Login
        </router-link>
        <router-link to="/tracker" v-show="state.isAuthenticated" exact>
          Tracker
        </router-link>
        <a href="#" v-show="state.isAuthenticated">
          {{ state.authenticatedUsername }}
        </a>
        <router-link to="/logout" v-show="state.isAuthenticated" exact>
          Logout
        </router-link>
      </div>
    </nav>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from "vue";
// import twitterIcon from '../assets/images/twitter.svg';
import UserAuthenticationService from '../services/user-authentication.service';

export default defineComponent({
  setup() {
    let state = reactive<{
      isAuthenticated: boolean,
      authenticatedUsername: string
    }>({
      isAuthenticated: UserAuthenticationService.authenticated,
      authenticatedUsername: UserAuthenticationService.payload.username,
    });

    return {
      state,
    }
  }
})
</script>

<style scoped>
nav {
  background-color: var(--navbar-background-color);
  height: auto;
  line-height: var(--navbar-height);
  min-height: var(--navbar-height);
  padding: 0 15px;
  margin-bottom: 35px;

  & #logo {
    width: 47px;
    height: 47px;
  }
  & .title a {
    float: left;
    margin: 0px 16px;
  }

  & .menu {
    text-align: center;
    width: 100%;
    display: none;

    & a {
      background-color: transparent;
      color: var(--light-blue);
      text-decoration: none;
      font-size: 25px;
      line-height: var(--navbar-height);

      clear: right;
      display: block;
      margin: 0;

      & svg {
        width:  20px;
        height: 20px;
        fill: var(--light-blue);
      }
    }
  }


  & label {
    color: var(--light-blue);
    font-size: 26px;
    line-height: var(--navbar-height);
    cursor: pointer;
    margin: 0 16px;

    display: block;
    width: 26px;
    float: right;
  }

  & #toggle {
    display: none;
  }

  & #toggle:checked + .menu {
    display: block;
  }
}

@media only screen and (min-width: 640px) {
  nav {
    & .menu {
      margin: 0 16px 0 0;
      text-align: right;
      display: block;

      & a {
        margin: -4px 20px;
        display: inline-block;
      }
    }

    & label {
      display: none;
    }
  }
}
</style>
