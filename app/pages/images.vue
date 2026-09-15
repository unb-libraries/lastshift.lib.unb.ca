<script setup lang="ts">
definePageMeta({ title: 'Images' })

const images = [
  { file: 'bon-ami.png', caption: 'Long-time "Mr. Bon Ami" Arthur Paradis greets Mayor Clem Tremblay' },
  { file: 'mill-pile.png', caption: 'Conveyor belt to the log pile in mill yard' },
  { file: 'mill-truck.png', caption: 'Load liners for aligning logs for transport on public roads' },
  { file: 'chaleur.png', caption: 'Chaleur Inn on Montgomery St.' },
  { file: 'mill.png', caption: 'Arial panorama of mill, looking north' },
  { file: 'street.png', caption: 'Arial view of William St., looking west' },
  { file: 'water.png', caption: 'Port of Dalhousie Cargo Wharf, looking east (Michael Levesque photo)' },
  { file: 'snow-street.png', caption: 'Façade of mill along William St.' },
  { file: 'boots.png', caption: 'Iconic representation of mill work: steel-toed boots and aluminum lunch pail (Michael Levesque photo)' },
  { file: 'build.png', caption: 'Final stages of mill demolition' },
]
</script>

<template>
  <main>
    <div class="images-gallery text-center">
      <figure v-for="image in images" :key="image.file">
        <img :src="`/images/${image.file}`" :alt="image.caption" class="mx-auto max-w-full">
        <figcaption>{{ image.caption }}</figcaption>
      </figure>
    </div>
  </main>
</template>
