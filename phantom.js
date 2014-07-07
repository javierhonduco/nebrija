var page = require('webpage').create();
var url = "http://lema.rae.es/drae/srv/search?val=amor"

page.open(url, function () {
    console.log(page.content);
    phantom.exit();
});
