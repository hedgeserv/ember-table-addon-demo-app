# ember-table-addon-demo-app

Demo app for our fork of Addepar's <code>ember-table-addon</code>.

## Build Prerequisites

### Build script 

You can run `install-dependencies.sh` instead of manual installation

### Build manual

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/) - `brew install git`
* [Node.js](http://nodejs.org/) - `brew install nodejs`
* [Bower](http://bower.io/) - `npm install -g bower`
* [Ember CLI](http://www.ember-cli.com/) - `npm install -g ember-cli`
* [PhantomJS](http://phantomjs.org/) - `npm install -g phantomjs`
* [ember-table-addon](https://github.com/hedgeserv/ember-table-addon) - see below
* [Python](https://www.python.org/) (2.7) - `brew install python`
* [Mountebank](http://www.mbtest.org/)(^1.2.122) - `npm install -g mountebank --production`

### Npm link for ember-table-addon (for reuse later)

Your will need to make [our fork of](https://github.com/hedgeserv/ember-table-addon) ember-table-addon locally available. Clone that project too, to an adjacent directory.

Change into the ember-table-addon directory, and link it:

* `cd ../ember-table-addon && npm link`

## Installation (and using the link above)
Ensure you're cd'd to the cloned ember-table-addon-demo-app working-copy directory
* `npm link ember-table`
* `npm install` (installing server-side modules locally)
* `bower install` (installing client-side modules locally)

## Running / Development

* Start Mountebank - `mb --allowCORS &`
* Setup imposters `node mountebank-server/setup-imposters.js `
* `ember server`
* Visit [http://localhost:4200/fully-loaded-loans](http://localhost:4200/fully-loaded-loans) for demo of [Fully Loaded Set of Loans](https://github.com/hedgeserv/ember-table-addon-demo-app/wiki/Fully-Loaded-Set-of-Loans).


### Running Ember Tests

* `ember test` (runs tests with phantomjs and just reports a pass/fail)
* `ember test --server` (runs tests with chrome and just reports a pass/fail)

### Running Webdriver Tests

You will need to install required Python package and download chrome driver

* download [chrome driver for mac](http://chromedriver.storage.googleapis.com/2.15/chromedriver_mac32.zip)
* put chromedriver on system path
* `ember serve -e ci`
* `pip install -r python-webdriver-tests/requirements.txt`
* `nosetests`

### Building

* `ember build` (development)
* `ember build --environment production` (production)

### Continuous Integration
#### Run ember tests and python tests
* `sh test-ci.sh`

#### Travis and Jenkins
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

