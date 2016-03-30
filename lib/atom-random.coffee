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
      'atom-random:reseed': => @reseed()

    chance = @chance

    @commands = {
      'atom-random:string': => @random(chance.string()),
      'atom-random:guid': => @random(chance.guid()),
      'atom-random:integer': => @random(chance.integer())
      'atom-random:boolean': => @random(chance.bool())
      'atom-random:character': => @random(chance.character())
      'atom-random:floating': => @random(chance.floating())
      'atom-random:natural': => @random(chance.natural())
      'atom-random:paragraph': => @random(chance.paragraph())
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
