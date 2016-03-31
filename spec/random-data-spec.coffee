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
  it "inserts random android_id", ->
    spyOn(chance, 'android_id').andReturn('APA91loebnEQiOc0QTE2bEQb3pQyWM7SIGUXgabBmROqhvDTyR078JXxW6FQBRWRDnk9tzV7GOp-QDGWDPwYqfWNJ-bMYiwbmU0nA_1-4-RVV3tFuYT6CZAy3_CNLbMX40tKsoCrMb10OskS_9i11wjhRwE33AFket90QYC1ofRk8om32Vw1zH8')
    dataTest 'android_id', 'APA91loebnEQiOc0QTE2bEQb3pQyWM7SIGUXgabBmROqhvDTyR078JXxW6FQBRWRDnk9tzV7GOp-QDGWDPwYqfWNJ-bMYiwbmU0nA_1-4-RVV3tFuYT6CZAy3_CNLbMX40tKsoCrMb10OskS_9i11wjhRwE33AFket90QYC1ofRk8om32Vw1zH8'
  it "inserts random apple_token", ->
    spyOn(chance, 'apple_token').andReturn('9d8a442293a3d393c8eb72dd74bae6966c37e998bebfcf6da5cb5faa5829e766')
    dataTest 'apple_token', '9d8a442293a3d393c8eb72dd74bae6966c37e998bebfcf6da5cb5faa5829e766'
  it "inserts random bb_pin", ->
    spyOn(chance, 'bb_pin').andReturn('5352a6ef')
    dataTest 'bb_pin', '5352a6ef'
  it "inserts random wp7_anid", ->
    spyOn(chance, 'wp7_anid').andReturn('A=A3A1192DF99C5B79ACC76E28B5CD8950&E=23d&W=0')
    dataTest 'wp7_anid', 'A=A3A1192DF99C5B79ACC76E28B5CD8950&E=23d&W=0'
  it "inserts random wp8_anid2", ->
    spyOn(chance, 'wp8_anid2').andReturn('ZWQ3YzNlODkzYmJhNThlNjFlZjUxMWZjZTE4OWRkYTc=')
    dataTest 'wp8_anid2', 'ZWQ3YzNlODkzYmJhNThlNjFlZjUxMWZjZTE4OWRkYTc='
  it "inserts random avatar", ->
    spyOn(chance, 'avatar').andReturn('//www.gravatar.com/avatar/f958e39e591e12782462ff93e49c50ac')
    dataTest 'avatar', '//www.gravatar.com/avatar/f958e39e591e12782462ff93e49c50ac'
  it "inserts random color", ->
    spyOn(chance, 'color').andReturn('rgb(75,163,43)')
    dataTest 'color', 'rgb(75,163,43)'
  it "inserts random domain", ->
    spyOn(chance, 'domain').andReturn('sa.gov')
    dataTest 'domain', 'sa.gov'
  it "inserts random email", ->
    spyOn(chance, 'email').andReturn('fuc@monwan.io')
    dataTest 'email', 'fuc@monwan.io'
  it "inserts random fbid", ->
    spyOn(chance, 'fbid').andReturn('1000059066282306')
    dataTest 'fbid', '1000059066282306'
  it "inserts random google_analytics", ->
    spyOn(chance, 'google_analytics').andReturn('UA-131570-79')
    dataTest 'google_analytics', 'UA-131570-79'
  it "inserts random hashtag", ->
    spyOn(chance, 'hashtag').andReturn('#lile')
    dataTest 'hashtag', '#lile'
  it "inserts random ip", ->
    spyOn(chance, 'ip').andReturn('49.241.35.71')
    dataTest 'ip', '49.241.35.71'
  it "inserts random ipv6", ->
    spyOn(chance, 'ipv6').andReturn('9341:761d:3601:e9a9:cfcc:9f0c:a452:ffdd')
    dataTest 'ipv6', '9341:761d:3601:e9a9:cfcc:9f0c:a452:ffdd'
  it "inserts random klout", ->
    spyOn(chance, 'klout').andReturn('57')
    dataTest 'klout', '57'
  it "inserts random tld", ->
    spyOn(chance, 'tld').andReturn('net')
    dataTest 'tld', 'net'
  it "inserts random twitter", ->
    spyOn(chance, 'twitter').andReturn('@asu')
    dataTest 'twitter', '@asu'
  it "inserts random url", ->
    spyOn(chance, 'url').andReturn('http://sek.gov/hawvo')
    dataTest 'url', 'http://sek.gov/hawvo'
  it "inserts random address", ->
    spyOn(chance, 'address').andReturn('1831 Daad Court')
    dataTest 'address', '1831 Daad Court'
  it "inserts random altitude", ->
    spyOn(chance, 'altitude').andReturn('2884.88302')
    dataTest 'altitude', '2884.88302'
  it "inserts random areacode", ->
    spyOn(chance, 'areacode').andReturn('(418)')
    dataTest 'areacode', '(418)'
  it "inserts random city", ->
    spyOn(chance, 'city').andReturn('Lomkojana')
    dataTest 'city', 'Lomkojana'
  it "inserts random coordinates", ->
    spyOn(chance, 'coordinates').andReturn('-80.64074, 129.12049')
    dataTest 'coordinates', '-80.64074, 129.12049'
  it "inserts random country", ->
    spyOn(chance, 'country').andReturn('SC')
    dataTest 'country', 'SC'
  it "inserts random phone", ->
    spyOn(chance, 'phone').andReturn('(906) 578-9097')
    dataTest 'phone', '(906) 578-9097'
  it "inserts random postal", ->
    spyOn(chance, 'postal').andReturn('G7P 2I0')
    dataTest 'postal', 'G7P 2I0'
  it "inserts random province", ->
    spyOn(chance, 'province').andReturn('PE')
    dataTest 'province', 'PE'
  it "inserts random state", ->
    spyOn(chance, 'state').andReturn('DC')
    dataTest 'state', 'DC'
  it "inserts random street", ->
    spyOn(chance, 'street').andReturn('Joza Grove')
    dataTest 'street', 'Joza Grove'
  it "inserts random zip", ->
    spyOn(chance, 'zip').andReturn('22319')
    dataTest 'zip', '22319'
