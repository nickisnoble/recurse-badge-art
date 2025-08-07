<script lang="ts">
  import Back from "$lib/components/Back.svelte";
  import Front from "$lib/components/Front.svelte";

  let name = $state("Nick Noble");
  let batch = $state("Summer '1");
  let frontComponent: Front;
  let backComponent: Back;

  function downloadBothSides() {
    // Download front
    if (frontComponent?.p5Instance) {
      frontComponent.p5Instance.save(`recurse-badge-front-${name.replace(/\s+/g, '-').toLowerCase()}.png`);
    }
    
    // Download back
    if (backComponent?.p5Instance) {
      backComponent.p5Instance.save(`recurse-badge-back-${name.replace(/\s+/g, '-').toLowerCase()}.png`);
    }
  }
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
    placeholder="Name"
  />

  <input
    class="bg-white/20"
    type="text"
    name="batch"
    id="batch"
    bind:value={batch}
    placeholder="Batch (e.g. Summer '1)"
  />

  <div class="flex gap-8 items-start">
    <div class="flex flex-col gap-2">
      <h2 class="text-lg font-semibold">Front</h2>
      <Front {name} {batch} bind:this={frontComponent} />
    </div>
    
    <div class="flex flex-col gap-2">
      <h2 class="text-lg font-semibold">Back</h2>
      <Back {name} {batch} bind:this={backComponent} />
    </div>
  </div>

  <button
    class="mt-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
    onclick={downloadBothSides}
  >
    Download Both Sides
  </button>
</main>
