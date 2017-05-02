import Ember from 'ember';
import RSVP from 'rsvp';
const url = "//mapc-admin.carto.com/api/v2/sql?q=";
const query = "SELECT DISTINCT(st_name_1) AS name, lat, long FROM %22mapc-admin%22.survey_intersection WHERE town_id=1";

export default Ember.Route.extend({
  ajax: Ember.inject.service(),
  queryParams: {
    firstSelection: {
      refreshModel: true,
      replace: true
    }
  },
  model(params) {
    let query2 = query;

    if (params.firstSelection) {
      query2 = `SELECT DISTINCT(st_name_2) AS name, lat,long FROM%20%22mapc-admin%22.survey_intersection%20WHERE%20st_name_1='${params.firstSelection}' AND town_id=1`;  
    }

    return RSVP.hash({
      firstStreets: this.get('ajax').request(`${url}${query}`),
      secondStreets: this.get('ajax').request(`${url}${query2}`)
    })
  },
  afterModel(streets, transition) {
    let secondStreets = streets.secondStreets.rows;
    if(secondStreets.length == 1) {
      this.controllerFor('survey').set('secondSelection', secondStreets[0]);
    }
  }
});
