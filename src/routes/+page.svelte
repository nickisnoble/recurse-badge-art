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

<main class="min-h-screen bg-white">
  <div class="max-w-4xl mx-auto px-8 py-12">
    <div class="text-center mb-12">
      <h1 class="text-4xl font-bold mb-4 text-gray-900">Recurse Badge Generator</h1>
      <p class="text-gray-600 text-lg">Create your personalized RC badge</p>
    </div>

    <div class="mb-8 space-y-4 max-w-md mx-auto">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700 mb-2">Name</label>
        <input
          class="w-full px-4 py-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-900 focus:border-transparent"
          type="text"
          name="name"
          id="name"
          autocomplete="name"
          bind:value={name}
          placeholder="Enter your name"
        />
      </div>

      <div>
        <label for="batch" class="block text-sm font-medium text-gray-700 mb-2">Batch</label>
        <input
          class="w-full px-4 py-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-900 focus:border-transparent"
          type="text"
          name="batch"
          id="batch"
          bind:value={batch}
          placeholder="e.g. Summer '1, Fall '2"
        />
      </div>
    </div>

    <div class="flex justify-center gap-12 items-start mb-8 flex-wrap">
      <div class="flex flex-col gap-3 items-center">
        <h2 class="text-lg font-semibold text-gray-900">Front</h2>
        <Front {name} {batch} bind:this={frontComponent} />
      </div>
      
      <div class="flex flex-col gap-3 items-center">
        <h2 class="text-lg font-semibold text-gray-900">Back</h2>
        <Back {name} {batch} bind:this={backComponent} />
      </div>
    </div>

    <div class="text-center">
      <button
        class="px-8 py-4 bg-green-600 text-white font-medium rounded-md hover:bg-green-700 transition-colors focus:outline-none focus:ring-2 focus:ring-green-600 focus:ring-offset-2"
        onclick={downloadBothSides}
      >
        Download Both Sides
      </button>
    </div>
  </div>
</main>
