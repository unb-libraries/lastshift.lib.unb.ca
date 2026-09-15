<script setup lang="ts">
// Baked in at build/generate time since the site is static — a rebuild
// is required to roll the copyright year over.
const year = new Date().getFullYear()
</script>

<template>
  <footer class="site-footer">
    <a href="https://lib.unb.ca" target="_blank" rel="noopener">
      <img src="/images/unb-libraries-white.png" alt="UNB Libraries" class="footer-logo">
    </a>
    <p class="mb-0">
      © {{ year }} Tony Tremblay. All Rights Reserved.
    </p>
  </footer>
</template>
