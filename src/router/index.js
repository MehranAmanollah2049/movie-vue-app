import { createRouter, createWebHistory } from 'vue-router'

import { useToken } from '@/stores/Authentication/useToken'
import { useAuth } from '@/stores/Authentication/useAuth'
import { RouteSaver } from '@/stores/RouteSaver'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  scrollBehavior(to, from, savedPosition) {
    document.getElementById("app").scrollIntoView({ behavior: "smooth" });
  },
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/HomeView.vue')
    },
    {
      path: '/all-movies',
      name: 'all-movies',
      component: () => import('@/views/AllMoviesView.vue'),
    },
    {
      path: '/movie/:id',
      name: 'movie',
      component: () => import('@/views/Movie.vue'),
    },
    {
      path: '/auth',
      name: 'auth',
      component: () => import('@/views/Authentication/Layout.vue'),
      meta: { requireGuest: true },
      children: [
        {
          path: 'login',
          name: 'auth.login',
          component: () => import('@/views/Authentication/Login.vue')
        },
        {
          path: 'register',
          name: 'auth.register',
          component: () => import('@/views/Authentication/Register.vue')
        },
        {
          path: 'verify',
          name: 'auth.verify',
          component: () => import('@/views/Authentication/Verify.vue'),
          meta: { verifyPage: true }
        },
        {
          path: 'forget-password',
          name: 'auth.forget-password',
          component: () => import('@/views/Authentication/ForgetPassword.vue')
        },
        {
          path: 'change-password',
          name: 'auth.change-password',
          component: () => import('@/views/Authentication/ChangePassword.vue'),
          meta: { changePasswordPage: true }
        },
      ]
    },
  ]
})

router.beforeEach((to, from) => {

  if (!to?.name?.includes("auth")) {
    let routeStore = RouteSaver()
    routeStore.previous = to?.fullPath
  }

  let tokenStore = useToken();
  let isAuthenticated = tokenStore.token;

  let authStore = useAuth()

  if (to.meta.requireGuest && isAuthenticated) {
    return '/';
  }

  if (to.meta.verifyPage && !authStore.canAccessToVerify) {
    return '/auth/login'
  }

  if (to.meta.changePasswordPage && !authStore.canAccessToChangePass) {
    return '/auth/forget-password'
  }

  if (to.name == 'auth') {
    return { name: 'auth.login' };
  }


})



export default router
