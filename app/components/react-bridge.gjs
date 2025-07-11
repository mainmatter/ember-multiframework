import './react-bridge.css';

import { registerDestructor } from '@ember/destroyable';
import { isTesting, macroCondition } from '@embroider/macros';
import { getOwner } from '@ember/owner';
import Modifier from 'ember-modifier';

import { act, createElement } from 'react';
import { createRoot } from 'react-dom/client';
import { App } from './react/app.jsx';

function or(a, b) {
  return a ?? b;
}

function cleanup(instance) {
  if (macroCondition(isTesting())) {
    window.IS_REACT_ACT_ENVIRONMENT = true;
    act(() => {
      instance.root?.unmount();
    });
  } else {
    instance.root?.unmount();
  }
}

class ReactModifier extends Modifier {
  root = null;
  children = null;
  owner = getOwner(this);

  modify(element, positional, { component, props, providerOptions }) {
    if (!this.root) {
      this.root = createRoot(element);
      registerDestructor(this, cleanup);
    }

    const wrappedComponent = createElement(
      App,
      { owner: this.owner, providerOptions },
      createElement(component, props, this.children)
    );

    if (macroCondition(isTesting())) {
      window.IS_REACT_ACT_ENVIRONMENT = true;
      act(() => {
        this.root?.render(wrappedComponent);
      });
    } else {
      this.root.render(wrappedComponent);
    }
  }
}

<template>
  {{#let (or @hasBlock (has-block)) as |normalizedHasBlock|}}
    <div
      class="react-bridge-component"
      data-test-react-bridge-component
      {{ReactModifier
        component=@component
        props=@props
        providerOptions=@providerOptions
      }}
      ...attributes
    >
      {{~#if normalizedHasBlock~}}
        {{yield}}
      {{/if}}
    </div>
  {{/let}}
</template>
