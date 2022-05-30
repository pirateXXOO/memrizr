<template>
  <div>
    <UserForm v-if="meData && !meLoading" :user="meData.user" />
    <LoaderCom
      v-if="meLoading"
      :height="256"
      class="animate-spin stroke-current text-blue-500 mx-auto"
    />
    <p v-if="meError" class="text-center text-red-500">Error fetching user</p>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import { useAuth } from '../store/auth';
import { useRequest } from '../util';
import UserForm from '../components/UserForm.vue';
import LoaderCom from '../components/ui/Loader.vue';


export default defineComponent({
    name: "DetailsCom",
    components: {
      UserForm,
      LoaderCom
    },
    setup() {
      const { idToken } = useAuth();

      const { data: meData, error: meError, loading: meLoading } = useRequest(
        {
          url: '/api/account/me',
          method: 'get',
          headers: {
            Authorization: `Bearer ${idToken.value}`,
          },
        },
        {
          execOnMounted: true,
        }
      );

      return {
        meData,
        meError,
        meLoading,
      };
    },
});
</script>
