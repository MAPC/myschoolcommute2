import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('intersecting-streets', 'Integration | Component | intersecting streets', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{intersecting-streets}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#intersecting-streets}}
      template block text
    {{/intersecting-streets}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
