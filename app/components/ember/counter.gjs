import { on } from '@ember/modifier';

<template>
  <section>
    <h3>Ember.JS Counter</h3>
    <span data-test-counter>{{@counter}}</span>

    <button
      type="button"
      {{on "click" @onCounterClick}}
      data-test-increment-button
    >+1</button>
  </section>
</template>
