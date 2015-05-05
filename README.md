# ember-table-addon-demo-app

Demo app for "ember-table-addon".

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/) - `brew install git`
* [Node.js](http://nodejs.org/) - `brew install nodejs`
* [Bower](http://bower.io/) - `npm install -g bower`
* [Ember CLI](http://www.ember-cli.com/) - `npm install -g ember-cli`
* [PhantomJS](http://phantomjs.org/) - `npm install -g phantomjs`
* [ember-table-addon](https://github.com/hedgeserv/ember-table-addon) - see below
* [Python](https://www.python.org/) (2.7) - `brew install python`
* [Mountebank](http://www.mbtest.org/) - `npm install -g mountebank --production`

### Npm link for ember-table-addon (for reuse later)

Your will need to make ember-table-addon locally available

* Change into ember-table-addon directory
* `cd ../ember-table-addon && npm link`

## Installation (and using the link above)
Ensure you're cd'd to the cloned ember-table-addon-demo-app working-copy directory
* `npm link ember-table`
* `npm install` (installing server-side modules locally)
* `bower install` (installing client-side modules locally)

## Running / Development

* Start Mountebank
* Setup imposters `node mountebank-server/setup-imposters.js `
* `ember server`
* Visit [http://localhost:4200/loans](http://localhost:4200/loans) for demo of [Fully Loaded Set of Loans](https://github.com/hedgeserv/ember-table-addon-demo-app/wiki/Fully-Loaded-Set-of-Loans).


### Running Ember Tests

* `ember test`
* `ember test --server`

### Running Webdriver Tests

You will need to install required Python package and download chrome driver

* change into `python-webdriver-tests` directory
* `pip install -r requirements.txt`
* download [chrome driver for mac] (http://chromedriver.storage.googleapis.com/2.15/chromedriver_mac32.zip)
* put chromedriver on system path
* run `python fully_loaded_set_of_loans.py`

You will also need to put chrome driver  

### Building

* `ember build` (development)
* `ember build --environment production` (production)

### Continuous Integration

* TBD: update .travis.yml to install ember-table-addon as npm link first
* TBD: verify compatibility with Jenkins 
* TBD: integrate python webdriver tests

### Deploying

TBD.

## Further Reading / Useful Links

* [ember.js](http://emberjs.com/)
* [ember-cli](http://www.ember-cli.com/)
* Development Browser Extensions
  * [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
  * 

## Developer Tips


