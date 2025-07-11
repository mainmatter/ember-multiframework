<script>
  let { counter, onCounterClick } = $props();
</script>

<section>
  <h3>Svelte Counter</h3>

  <span data-test-counter>{counter}</span>

  <button
    type="button"
    onclick={() => onCounterClick()}
    data-test-increment-button>+1</button
  >
</section>
