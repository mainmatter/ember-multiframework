import { pageTitle } from 'ember-page-title';
import { hash } from '@ember/helper';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import EmberCounter from '../components/ember/counter.gjs';
import ReactBridge from '../components/react-bridge.gjs';
import SvelteBridge from '../components/svelte-bridge.gjs';

import { ReactCounter } from '../components/react/counter.jsx';
import SvelteCounter from '../components/svelte/counter.svelte';

export default class ApplicationRouteComponent extends Component {
  @tracked counter = 0;

  increaseCounter = () => {
    this.counter++;
  };

  <template>
    {{pageTitle "EmberMultiframework"}}

    <h1>Multiframework counters</h1>

    <EmberCounter
      @counter={{this.counter}}
      @onCounterClick={{this.increaseCounter}}
    />

    <ReactBridge
      @component={{ReactCounter}}
      @props={{hash counter=this.counter onCounterClick=this.increaseCounter}}
    />

    <SvelteBridge
      @component={{SvelteCounter}}
      @props={{hash counter=this.counter onCounterClick=this.increaseCounter}}
    />

    {{outlet}}
  </template>
}
