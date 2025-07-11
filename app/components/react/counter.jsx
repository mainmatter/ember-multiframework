export function ReactCounter({ counter, onCounterClick }) {
  return (
    <section>
      <h3>React Counter</h3>
      {counter}

      <button type="button" onClick={onCounterClick}>
        +1
      </button>
    </section>
  );
}
