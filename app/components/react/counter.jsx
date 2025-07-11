export function ReactCounter({ counter, onCounterClick }) {
  return (
    <section>
      <h3>React Counter</h3>
      <span data-test-counter>{counter}</span>

      <button type="button" onClick={onCounterClick} data-test-increment-button>
        +1
      </button>
    </section>
  );
}
