<script setup lang="ts">
// error.vue passes `title` explicitly since it has no route.meta (no definePageMeta);
// every other page sets its title via definePageMeta and is read off the route here.
const props = defineProps<{ title?: string }>()
const route = useRoute()
const title = computed(() => props.title ?? String(route.meta.title ?? ''))
useHead({ title })
</script>

<template>
  <div class="min-h-screen">
    <NuxtRouteAnnouncer />
    <header class="site-header">
      <NuxtLink to="/" class="site-header-logo">
        Last Shift
      </NuxtLink>
      <nav class="site-header-links" aria-label="Utility">
        <NuxtLink to="/contact">
          Contact
        </NuxtLink>
        <span aria-hidden="true">|</span>
        <NuxtLink to="/order">
          Order
        </NuxtLink>
      </nav>
    </header>
    <main>
      <div class="main-wrapper mx-auto max-w-[1140px]">
        <div class="page-banner">
          <h2 class="page-banner-title">
            Last Shift
          </h2>
          <p class="page-banner-subtitle">
            the story of a mill town
          </p>
        </div>
        <div class="page-title-bar">
          <hr>
          <h1>{{ title }}</h1>
          <hr>
        </div>
        <div class="flex flex-col gap-6 px-4 pb-8 lg:flex-row">
          <nav class="sidebar-nav lg:w-1/4" aria-label="Section">
            <NuxtLink to="/the-project" class="sidebar-nav-link">
              the project
            </NuxtLink>
            <NuxtLink to="/credits" class="sidebar-nav-link">
              credits
            </NuxtLink>
            <NuxtLink to="/trailer" class="sidebar-nav-link">
              watch a clip
            </NuxtLink>
            <NuxtLink to="/images" class="sidebar-nav-link">
              images
            </NuxtLink>
            <NuxtLink to="/comments" class="sidebar-nav-link">
              viewer comments
            </NuxtLink>
            <NuxtLink to="/post-screening" class="sidebar-nav-link">
              after screening the film
            </NuxtLink>
            <NuxtLink to="/reading" class="sidebar-nav-link">
              further reading
            </NuxtLink>
            <NuxtLink to="/links" class="sidebar-nav-link">
              links
            </NuxtLink>
          </nav>
          <div class="lg:w-3/4 lg:border-l lg:border-ink lg:pl-6">
            <slot />
          </div>
        </div>
      </div>
    </main>
    <SiteFooter class="mx-auto max-w-[1140px]" />
  </div>
</template>
