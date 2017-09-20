import Ember from 'ember';
import ENV from 'docyet-client/config/environment';

/**
 * Service to handle user authentication via Verimi login
 */
export default Ember.Service.extend({
  ajax: Ember.inject.service(),
  userSessionManager: Ember.inject.service(),
  router: Ember.inject.service(),

  /**
   * Redirects to Verimi client login form
   */
  loginInVerimi() {
    let clientId = ENV.verimiClientId;
    let redirectUri = ENV.verimiRedirectUrl;

    // Open new window
    location.replace(
      'http://verimi.com/dipp/api/oauth/service_provider_access/'+
      clientId + '?redirect_uri='+ redirectUri +'&scope=login');
  },

  /**
   * Request authentication in Docyet server via Verimi code
   * @param {string} verimiCode - code returned by Verimi login
   */
  loginInDocyet(verimiCode) {
    let component = this;
    this.get('ajax').post(ENV.host + '/verimi_users', { data: { code: verimiCode } }).then(
      (data) => {
        let credentials = {
          identification: data.user.email,
          password: 'random'};

        component.get('userSessionManager').login(credentials).then(
          (success) => { component.get('router').transitionTo('chatbot'); },
          (error)=>{});
      },
      () => {}
    );
  },

  /**
   * Redirects to Verimi user information page
   */
  getVerimiInformation() {
    window.open("https://verimi.de/en/#for-users");
  }
});
