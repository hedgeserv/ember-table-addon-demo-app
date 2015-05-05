# ember-table-addon-demo-app

Demo app for "ember-table-addon".

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/) (with NPM)
* [Bower](http://bower.io/)
* [Ember CLI](http://www.ember-cli.com/)
* [PhantomJS](http://phantomjs.org/)
* [ember-table-addon](https://github.com/hedgeserv/ember-table-addon)
* [Python](https://www.python.org/) (2.7)

### Npm link for ember-table-addon

Your will need to make ember-table-addon locally available

* Change into ember-table-addon directory
* `npm link`

## Installation
* `git clone <repository-url>` this repository
* change into the new directory
* `npm link ember-table`
* `npm install`
* `bower install`

## Running / Development

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


