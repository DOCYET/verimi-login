import Ember from 'ember';

export default Ember.Route.extend({
  verimiSessionManager: Ember.inject.service(),

  queryParams: {
    code: {
      refreshModel: true
    }
  },

  model(params) {
    this.get('verimiSessionManager').loginInDocyet(params.code);
    return Ember.RSVP.hash({
      code: params.code
    });
  }
});