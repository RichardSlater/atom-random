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

AtomRandom = require '../lib/random'

describe "Random Initialization", ->
  [oldChance] = []
  it "successfully adds commands", ->
    runs ->
      AtomRandom.activate()
      expect(AtomRandom.subscriptions.disposables.size).toBeGreaterThan(1)
  it "reseeds the chance object with a fake seed", ->
    runs ->
      spyOn(window, 'fetch').andCallFake ->
        return Promise.resolve
          'status': 200
          'text': ->
            return Promise.resolve 100

      oldChance = AtomRandom.chance
      AtomRandom.reseed()
    waitsFor ->
      return AtomRandom.chance.mt.mt[0] != oldChance.mt.mt[0]
    runs ->
      expect(AtomRandom.chance.mt.mt[0]).not.toBe(oldChance.mt.mt[0])
      expect(atom.notifications.notifications[0].type).toBe('success')
      expect(atom.notifications.notifications[0].message)
        .toBe('Success: new seed is 100')
  it "reseeds the chance object with a different fake seed", ->
    runs ->
      spyOn(window, 'fetch').andCallFake ->
        return Promise.resolve
          'status': 200
          'text': ->
            return Promise.resolve 789

      oldChance = AtomRandom.chance
      AtomRandom.reseed()
    waitsFor ->
      return AtomRandom.chance.mt.mt[0] != oldChance.mt.mt[0]
    runs ->
      expect(atom.notifications.notifications[0].message)
        .toBe('Success: new seed is 789')
  it "fails when fetching the seed", ->
    runs ->
      spyOn(window, 'fetch').andCallFake ->
        return Promise.resolve
          'status': 500
          'text': ->
            return Promise.resolve 'Internal Server Error'

      oldChance = AtomRandom.chance
      AtomRandom.reseed()
    waitsFor ->
      return atom.notifications.notifications.length > 0
    runs ->
      expect(AtomRandom.chance.mt.mt[0]).toBe(oldChance.mt.mt[0])
      expect(atom.notifications.notifications[0].type).toBe('error')
      expect(atom.notifications.notifications[0].message)
        .toBe('Error: unable to fetch seed from random.org: \
                Internal Server Error')
describe "Activation Commands", ->
  [activationPromise] = []
  it "has an activation command for each subscription", ->
    runs ->
      activationPromise = atom.packages.activatePackage("random")
      atom.packages.getLoadedPackage('random').activateNow()

    waitsForPromise ->
      activationPromise

    runs ->
      atomRandom = atom.packages.getActivePackage('random')
      activationCommands = atomRandom.activationCommands['atom-workspace']
      registeredCommands = atomRandom.mainModule.commands
      expect(activationCommands)
        .toContain(cmd) for cmd of registeredCommands
describe "Menu Commands", ->
  [activationPromise] = []
  it "has an activation command for each subscription", ->
    runs ->
      activationPromise = atom.packages.activatePackage("random")
      atom.packages.getLoadedPackage('random').activateNow()

    waitsForPromise ->
      activationPromise

    runs ->
      atomRandom = atom.packages.getActivePackage('random')
      subMenus = (m.command for m in atomRandom.menus[0][1].menu[0].submenu)
      console.log subMenus
      registeredCommands = atomRandom.mainModule.commands
      expect(subMenus)
        .toContain(cmd) for cmd of registeredCommands
