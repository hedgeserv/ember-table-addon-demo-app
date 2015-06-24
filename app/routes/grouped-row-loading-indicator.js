import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    return [
      {
        id: 1,
        isLoading: false,
        children: [
          {
            id: 11,
            isLoading: false,
            children: [
              {
                id: 111,
                isLoading: true
              }
            ]
          }
        ]
      },
      {
        id: 2,
        isLoading: false,
        children: [
          {
            id: 21,
            isLoading: false,
            children: [
              {
                id: 211,
                isLoading: true
              }
            ]
          }
        ]
      }
    ];
  }
});
