import { createApp } from 'vue';
import App from './App.vue';
import router from './routes';
import './validators';
import './index.css';
import { createAuthStore } from '../src/store/auth';

const authStore = createAuthStore({
  onAuthRoute: '/',
  requireAuthRoute: '/authenticate',
});

createApp(App).use(authStore).use(router).mount('#app');
