<script>
  let { counter, onCounterClick } = $props();
</script>

<section>
  <h3>Svelte Counter</h3>

  {counter}

  <button type="button" onclick={() => onCounterClick()}>+1</button>
</section>
