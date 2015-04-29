/* jshint expr:true */
import { expect } from 'chai';
import {
  describeModel,
  it
} from 'ember-mocha';

describeModel(
  'loan',
  'Loan',
  {
    // Specify the other units that are required for this test.
      needs: []
  },
  function() {
    // Replace this with your real tests.
    it('exists', function() {
      var model = this.subject();
      expect(model).to.be.ok;
    });
  }
);
