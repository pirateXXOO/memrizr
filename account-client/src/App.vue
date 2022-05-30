<template>
  <div class="mx-8 my-8">
    <LoaderCom 
      v-if="isLoading"
      :height="512"
      class="animate-spin stroke-current text-blue-500 mx-auto"
    />
    <router-view v-else></router-view>
  </div>
</template>

<script>
import { defineComponent, onMounted } from 'vue';
import LoaderCom from './components/ui/Loader.vue';
import { useAuth } from './store/auth';

// Wrapping exported object in define component
// gives us typing help! Woot!
export default defineComponent({
  name: 'App',
  components: {
    LoaderCom,
  },
  setup() {
    const { initializeUser, isLoading } = useAuth();

    onMounted(() => {
      initializeUser();
    });

    return {
      isLoading,
    };
  },
});
</script>
