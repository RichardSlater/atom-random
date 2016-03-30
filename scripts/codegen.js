var args = require('minimist')(process.argv.slice(2));
var CSON = require('cson');
var chance = require('chance').Chance();

var usage = function () {
  console.log('Usage:');
  console.log('  node codegen --atomNoun <noun> --menuText <menu-text> --chanceNoun <noun>')
  console.log('\nExample:');
  console.log('  node codegen --atomNoun boolean --menuText Boolean --chanceNoun bool')
}

var hasArgAtomNoun = args.hasOwnProperty('atomNoun');
var hasArgMenuText = args.hasOwnProperty('menuText');
var hasArgChanceNoun = args.hasOwnProperty('chanceNoun');

if (!hasArgAtomNoun || !hasArgMenuText || !hasArgChanceNoun) {
  usage();
  return;
}

var fs = require('fs');
var packageJson = '../package.json';
var newCommand = 'atom-random:' + args['atomNoun'];

fs.readFile(packageJson, 'utf8', function read(err, data) {
  if (err) {
    throw err;
  }
  var packageParsed = JSON.parse(data);
  var activationCommands = packageParsed.activationCommands['atom-workspace'];
  if (activationCommands.indexOf(newCommand) === -1) {
    activationCommands.push(newCommand);
    data = JSON.stringify(packageParsed, null, 2);

    fs.writeFile(packageJson, data, 'utf8', (err) => {
      if (err) throw err;
      console.log('[✓] update successful, added "' + newCommand + '" to packages.json');
    });
  } else {
    console.log('[ ] package.json already contains "' + newCommand + '"')
  }
});

var libCoffee = '../lib/atom-random.coffee';

fs.readFile(libCoffee, 'utf8', function read(err, data) {
  if (err) {
    throw err;
  }
  var newCoffee = "'" + newCommand + "': => @random(chance." + args.chanceNoun + "())";
  if (data.indexOf(newCoffee) === -1) {
    data = data.replace(/# additional commands go here/g, newCoffee + "\r\n      # additional commands go here");
    fs.writeFile(libCoffee, data, 'utf8', (err) => {
      if (err) throw err;
      console.log('[✓] update successful, added "' + newCommand + '" to atom-random.coffee');
    });
  } else {
    console.log('[ ] atom-random.coffee already contains "' + newCommand + '"')
  }
});

var specCoffee = '../spec/atom-random-data-spec.coffee';

fs.readFile(specCoffee, 'utf8', function read(err, data) {
  if (err) {
    throw err;
  }
  var randomData = eval("chance." + args.chanceNoun + "();");
  var newSpec = "  it \"inserts random " + args.chanceNoun + "\", ->" + "\n" +
      "    dataTest '" + args.atomNoun + "', '" + randomData + "'" + "\n" +
      "    spyOn(chance, '" + args.chanceNoun + "').andReturn('" + randomData + "')" + "\n";

  if (data.indexOf("inserts random " + args.chanceNoun) === -1) {
    data = data + newSpec;
    fs.writeFile(specCoffee, data, 'utf8', (err) => {
      if (err) throw err;
      console.log('[✓] update successful, added "' + newCommand + '" to atom-random-data-spec.coffee');
    });
  } else {
    console.log('[ ] atom-random-data-spec.coffee already contains "' + newCommand + '"')
  }
});

var menuCson = '../menus/atom-random.cson';

fs.readFile(menuCson, 'utf8', function read(err, data) {
  if (err) {
    throw err;
  }
  var menuParsed = CSON.parse(data);
  var tail = menuParsed.menu[0].submenu.slice(-2);
  var subMenu = menuParsed.menu[0].submenu.slice(0, menuParsed.menu[0].submenu.length - 2)
  var newMenu = {
  	"label": "Random " + args.menuText,
  	"command": newCommand
  };

  if (subMenu.map((x) => x.command).indexOf(newCommand) === -1) {
    subMenu.push(newMenu);
    menuParsed.menu[0].submenu = subMenu.concat(tail);

    data = CSON.stringify(menuParsed, null, 2);

    fs.writeFile(menuCson, data, 'utf8', (err) => {
      if (err) throw err;
      console.log('[✓] update successful, added "' + newCommand + '" to atom-random.cson');
    });
  } else {
    console.log('[ ] atom-random.cson already contains "' + newCommand + '"')
  }
});
