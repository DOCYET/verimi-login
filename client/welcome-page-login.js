import Ember from 'ember';

export default Ember.Component.extend({
  // Component Properties
  verimiSessionManager: Ember.inject.service(),

  actions: {
    /**
     * Redirects to Verimi login page
     */
    navigateToVerimiLogin() {
      this.get('verimiSessionManager').loginInVerimi()
    }
  }
});
