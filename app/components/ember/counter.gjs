import { on } from "@ember/modifier";

<template>
  <section>
    <h3>Ember.JS Counter</h3>
    {{@counter}}

    <button type="button" {{on "click" @onCounterClick}}>+1</button>
  </section>
</template>
