task 'clean', 'clean .js', ->
  require('fs').unlink 'lib/ref.js', (e) ->
    console.log if e and e.code != 'ENOENT' then e else 'done'

task 'compile', 'compile .coffee', ->
  require('child_process').exec 'coffee -c lib/json-ref.coffee', (e, stdout, stderr) ->
    console.log if e then stderr else 'done'

task 'test', 'run tests', ->
  require('child_process').exec 'coffee test/test.coffee', (e, stdout, stderr) ->
    console.log if e then stderr else 'done'
