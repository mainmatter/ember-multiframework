export function reactive_props(props) {
  let state = $state({
    ...props,
  });

  return state;
}
