import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-multiframework/tests/helpers';
import { click, render } from '@ember/test-helpers';
import { hash } from '@ember/helper';
import { TrackedObject } from 'tracked-built-ins';

import ReactBridge from 'ember-multiframework/components/react-bridge.gjs';
import SvelteBridge from 'ember-multiframework/components/svelte-bridge.gjs';
import Counter from 'ember-multiframework/components/ember/counter.gjs';
import { ReactCounter } from 'ember-multiframework/components/react/counter.jsx';
import SvelteCounter from 'ember-multiframework/components/svelte/counter.svelte';

module('Integration | Component | ember/counter', function (hooks) {
  setupRenderingTest(hooks);

  test('[Ember] it should trigger the onCounterClick action when clicked', async function (assert) {
    const state = new TrackedObject({
      count: 0,
      incrementCount: () => {
        state.count++;
        assert.step('incrementCount');
      },
    });

    await render(
      <template>
        <Counter
          @counter={{state.count}}
          @onCounterClick={{state.incrementCount}}
        />
      </template>
    );

    assert.strictEqual(state.count, 0);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);

    await click('[data-test-increment-button]');

    assert.strictEqual(state.count, 1);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);
    assert.verifySteps(['incrementCount']);
  });

  test('[React] it should trigger the onCounterClick action when clicked', async function (assert) {
    const state = new TrackedObject({
      count: 0,
      incrementCount: () => {
        state.count++;
        assert.step('incrementCount');
      },
    });

    await render(
      <template>
        <ReactBridge
          @component={{ReactCounter}}
          @props={{hash
            counter=state.count
            onCounterClick=state.incrementCount
          }}
        />
      </template>
    );

    assert.strictEqual(state.count, 0);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);

    await click('[data-test-increment-button]');

    assert.strictEqual(state.count, 1);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);
    assert.verifySteps(['incrementCount']);
  });

  test('[Svelte] it should trigger the onCounterClick action when clicked', async function (assert) {
    const state = new TrackedObject({
      count: 0,
      incrementCount: () => {
        state.count++;
        assert.step('incrementCount');
      },
    });

    await render(
      <template>
        <SvelteBridge
          @component={{SvelteCounter}}
          @props={{hash
            counter=state.count
            onCounterClick=state.incrementCount
          }}
        />
      </template>
    );

    assert.strictEqual(state.count, 0);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);

    await click('[data-test-increment-button]');

    assert.strictEqual(state.count, 1);
    assert.dom('[data-test-counter]').hasText(`${state.count}`);
    assert.verifySteps(['incrementCount']);
  });
});
