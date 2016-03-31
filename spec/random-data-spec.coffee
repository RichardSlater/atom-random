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

describe "Random Data", ->
  [workspaceElement, activationPromise, editor, changeHandler, chance] = []

  dataTest = (dataType, expectValue) ->
    runs ->
      atom.commands.dispatch workspaceElement, "random:#{dataType}"

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
      expect(editor.getText()).toEqual expectValue

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      activationPromise = atom.packages.activatePackage("random")
      atom.packages.getLoadedPackage('random').activateNow()

    waitsForPromise ->
      activationPromise

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      workspaceElement = atom.views.getView(atom.workspace)
      changeHandler = jasmine.createSpy('changeHandler')
      editor.onDidChange(changeHandler)
      chance = atom.packages.getActivePackage('random').mainModule.chance

  it "inserts random string", ->
    spyOn(chance, 'string').andReturn('XuEFM!kalinXp')
    dataTest 'string', 'XuEFM!kalinXp'
  it "inserts random guid", ->
    spyOn(chance, 'guid').andReturn('e48c5e7d-7ca3-5de5-a25d-c81389d65ed3')
    dataTest 'guid', 'e48c5e7d-7ca3-5de5-a25d-c81389d65ed3'
  it "inserts random integer", ->
    spyOn(chance, 'integer').andReturn('123456789')
    dataTest 'integer', '123456789'
  it "inserts random boolean", ->
    spyOn(chance, 'bool').andReturn('true')
    dataTest 'boolean', 'true'
  it "inserts random character", ->
    spyOn(chance, 'character').andReturn('a')
    dataTest 'character', 'a'
  it "inserts random floating point number", ->
    spyOn(chance, 'floating').andReturn('789.123')
    dataTest 'floating', '789.123'
  it "inserts random paragraph", ->
    spyOn(chance, 'paragraph').andReturn(\
    """Ducgin hugim rab omepamna wir cocvira isadu tu savsa seecga pesut uzreov
    matuja dah ovatopgu insinzu lasuswog. Sat javkes vitpodpod esofuh ramliwe
    doz ufo zegnuttuf udicav zaal pacam tetvethoh vobomo diuzpab. Gel isfa hin
    set fe lumse ji ra fi vusgedma vej peb tuvej wates uligepceg pawelov jajop
    rap. Vop enonunane ena lewi ho akebubam ni zaun fehip jum eju nuzja wez.""")
    dataTest 'paragraph', \
    """Ducgin hugim rab omepamna wir cocvira isadu tu savsa seecga pesut uzreov
    matuja dah ovatopgu insinzu lasuswog. Sat javkes vitpodpod esofuh ramliwe
    doz ufo zegnuttuf udicav zaal pacam tetvethoh vobomo diuzpab. Gel isfa hin
    set fe lumse ji ra fi vusgedma vej peb tuvej wates uligepceg pawelov jajop
    rap. Vop enonunane ena lewi ho akebubam ni zaun fehip jum eju nuzja wez."""
  it "inserts random sentence", ->
    spyOn(chance, 'sentence').andReturn('Ham ebumo gihcov panvofa ova dowved pibvafo jej go wiaj uza kegamsu elu mom vamac cukurewa katubole.')
    dataTest 'sentence', 'Ham ebumo gihcov panvofa ova dowved pibvafo jej go wiaj uza kegamsu elu mom vamac cukurewa katubole.'
  it "inserts random syllable", ->
    spyOn(chance, 'syllable').andReturn('cos')
    dataTest 'syllable', 'cos'
  it "inserts random word", ->
    spyOn(chance, 'word').andReturn('lavles')
    dataTest 'word', 'lavles'
  it "inserts random age", ->
    spyOn(chance, 'age').andReturn('51')
    dataTest 'age', '51'
  it "inserts random birthday", ->
    spyOn(chance, 'birthday').andReturn('Mon Jun 02 1975 04:29:41 GMT+0100 (GMT Summer Time)')
    dataTest 'birthday', 'Mon Jun 02 1975 04:29:41 GMT+0100 (GMT Summer Time)'
  it "inserts random first", ->
    spyOn(chance, 'first').andReturn('Lucile')
    dataTest 'firstname', 'Lucile'
  it "inserts random last", ->
    spyOn(chance, 'last').andReturn('Castro')
    dataTest 'lastname', 'Castro'
  it "inserts random gender", ->
    spyOn(chance, 'gender').andReturn('Female')
    dataTest 'gender', 'Female'
  it "inserts random name", ->
    spyOn(chance, 'name').andReturn('Ola McKenzie')
    dataTest 'name', 'Ola McKenzie'
  it "inserts random prefix", ->
    spyOn(chance, 'prefix').andReturn('Miss')
    dataTest 'prefix', 'Miss'
  it "inserts random ssn", ->
    spyOn(chance, 'ssn').andReturn('066-32-4255')
    dataTest 'ssn', '066-32-4255'
  it "inserts random suffix", ->
    spyOn(chance, 'suffix').andReturn('Jr.')
    dataTest 'suffix', 'Jr.'
