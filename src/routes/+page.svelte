<script lang="ts">
  import Back from "$lib/components/Back.svelte";

  let name = $state("Nick Noble");
</script>

<main class="p-8 flex flex-col gap-4">
  <h1>Recurse Badge Generator</h1>

  <input
    class="bg-white/20"
    type="text"
    name="name"
    id="name"
    autocomplete="name"
    bind:value={name}
  />

  <Back {name} />
</main>
