# Copyright 2016 Richard Slater
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"use strict"

{CompositeDisposable} = require 'atom'
{Chance} = require 'chance'

module.exports = AtomRandom =
  subscriptions: null
  chance: null
  commands: null

  activate: (state) ->
    @chance = new Chance

    # Events subscribed to in atom's system can be easily
    # cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace',
      'random:reseed': => @reseed()

    chance = @chance

    @commands = {
      'random:string': => @random(chance.string()),
      'random:guid': => @random(chance.guid()),
      'random:integer': => @random(chance.integer())
      'random:boolean': => @random(chance.bool())
      'random:character': => @random(chance.character())
      'random:floating': => @random(chance.floating())
      'random:natural': => @random(chance.natural())
      'random:paragraph': => @random(chance.paragraph())
      'random:sentence': => @random(chance.sentence())
      'random:syllable': => @random(chance.syllable())
      'random:word': => @random(chance.word())
      'random:age': => @random(chance.age())
      'random:birthday': => @random(chance.birthday())
      'random:firstname': => @random(chance.first())
      'random:lastname': => @random(chance.last())
      'random:gender': => @random(chance.gender())
      'random:name': => @random(chance.name())
      'random:prefix': => @random(chance.prefix())
      'random:ssn': => @random(chance.ssn())
      'random:suffix': => @random(chance.suffix())
      'random:android_id': => @random(chance.android_id())
      'random:apple_token': => @random(chance.apple_token())
      'random:bb_pin': => @random(chance.bb_pin())
      'random:wp7_anid': => @random(chance.wp7_anid())
      'random:wp8_anid2': => @random(chance.wp8_anid2())
      'random:avatar': => @random(chance.avatar())
      'random:color': => @random(chance.color())
      'random:domain': => @random(chance.domain())
      'random:email': => @random(chance.email())
      'random:fbid': => @random(chance.fbid())
      'random:google_analytics': => @random(chance.google_analytics())
      'random:hashtag': => @random(chance.hashtag())
      'random:ip': => @random(chance.ip())
      'random:ipv6': => @random(chance.ipv6())
      'random:klout': => @random(chance.klout())
      'random:tld': => @random(chance.tld())
      'random:twitter': => @random(chance.twitter())
      'random:url': => @random(chance.url())
      'random:address': => @random(chance.address())
      'random:altitude': => @random(chance.altitude())
      'random:areacode': => @random(chance.areacode())
      'random:city': => @random(chance.city())
      'random:coordinates': => @random(chance.coordinates())
      'random:country': => @random(chance.country())
      'random:phone': => @random(chance.phone())
      'random:postal': => @random(chance.postal())
      'random:province': => @random(chance.province())
      'random:state': => @random(chance.state())
      'random:street': => @random(chance.street())
      'random:zip': => @random(chance.zip())
      'random:date': => @random(chance.date())
      'random:hammertime': => @random(chance.hammertime())
      'random:month': => @random(chance.month())
      'random:year': => @random(chance.year())
      'random:timestamp': => @random(chance.timestamp())
      # additional commands go here
    }

    @subscriptions.add atom.commands.add 'atom-workspace', @commands

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  reseed: ->
    parent = @
    errorHandler = (error) ->
      message = 'Error: unable to fetch seed from random.org: ' + error
      atom.notifications.addError message

    updateChance = (seed) ->
      parent.chance = new Chance(seed)
      atom.notifications.addSuccess 'Success: new seed is ' + seed

    query = '?num=1&col=1&min=1&max=1000000000&base=10&format=plain&rnd=new'
    fetch "https://random.org/integers/#{query}"
      .then (response) ->
        if response.status == 200
          response.text().then updateChance
        else
          response.text().then errorHandler
      .then null, errorHandler

  random: (data) ->
    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText(data.toString())
