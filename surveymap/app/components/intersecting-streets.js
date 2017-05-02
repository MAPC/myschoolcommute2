import Ember from 'ember';

export default Ember.Component.extend({
  bounds: Ember.computed('model.secondStreets.rows', 'secondSelection', function() {
    let secondStreetsLatLngs = this .get('model.secondStreets.rows')
                                    .map((street) => { return [] });
    return L.LatLngBounds(this.get('model.seconds'))
  }),
  secondStreetsCount: Ember.computed.alias('model.secondStreets.rows.length'),
  actions: {
    onFirstChange(selection) {
      this.set('firstSelection', selection);
      this.set('secondSelection', '');
    }
  }
});
