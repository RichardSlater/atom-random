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

AtomRandom = require '../lib/atom-random'

describe "Random Data", ->
  [workspaceElement, activationPromise, editor, changeHandler] = []

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      activationPromise = atom.packages.activatePackage("atom-random")
      atom.packages.getLoadedPackage('atom-random').activateNow()

    waitsForPromise ->
      activationPromise

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      workspaceElement = atom.views.getView(atom.workspace)
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      chance = atom.packages.getActivePackage('atom-random').mainModule.chance
      spyOn(chance, 'string').andReturn('XuEFM!kalinXp')
      spyOn(chance, 'guid').andReturn('e48c5e7d-7ca3-5de5-a25d-c81389d65ed3')
      spyOn(chance, 'integer').andReturn('123456789')
      spyOn(chance, 'bool').andReturn('true')

  it "inserts random string", ->
    runs ->
      atom.commands.dispatch workspaceElement, 'atom-random:string'

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
      expect(editor.getText()).toEqual 'XuEFM!kalinXp'

  it "inserts random guid", ->
    runs ->
      atom.commands.dispatch workspaceElement, 'atom-random:guid'

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
      expect(editor.getText()).toEqual 'e48c5e7d-7ca3-5de5-a25d-c81389d65ed3'

  it "inserts random integer", ->
    runs ->
      atom.commands.dispatch workspaceElement, 'atom-random:integer'

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
      expect(editor.getText()).toEqual '123456789'

  it "inserts random boolean", ->
    runs ->
      atom.commands.dispatch workspaceElement, 'atom-random:boolean'

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
      expect(editor.getText()).toEqual 'true'
