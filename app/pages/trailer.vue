<script setup lang="ts">
definePageMeta({ title: 'Watch A Clip' })
</script>

<template>
  <main>
    <div class="aspect-video w-full">
      <iframe
        class="h-full w-full"
        src="https://www.youtube.com/embed/twCtkUS59I0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      />
    </div>
  </main>
</template>
