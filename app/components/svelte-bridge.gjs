import { registerDestructor } from '@ember/destroyable';
import Modifier from 'ember-modifier';
import { assert } from '@ember/debug';

import { mount, unmount } from 'svelte';
import { reactive_props } from './svelte-bridge-utils.svelte.js';

function cleanup(instance) {
  unmount(instance.root, { outro: false });
  instance.props = null;
  instance.root = null;
}

class SvelteModifier extends Modifier {
  root = null;
  props = null;

  modify(element, positional, { component, props }) {
    assert(
      'You need to pass a component argument to the SvelteBridge component',
      Boolean(component)
    );

    if (!this.root) {
      this.props = reactive_props(props);
      this.root = mount(component, {
        target: element,
        props: this.props,
      });

      registerDestructor(this, cleanup);
    } else {
      for (let [key, value] of Object.entries(props)) {
        this.props[key] = value;
      }
    }
  }
}

<template>
  <div
    class="svelte-bridge-component"
    data-test-svelte-bridge-component
    {{SvelteModifier component=@component props=@props}}
    ...attributes
  ></div>
</template>
