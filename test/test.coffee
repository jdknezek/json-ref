assert = require 'assert'
ref = require '../lib/json-ref'

a = {}
b = {}
a.a = a
a.b = b
b.a = a
b.b = b

ref_a = ref.ref a
assert.equal ref_a.$id, '1'
assert.equal ref_a.a.$ref, '1'
assert.equal ref_a.b.$id, '2'
assert.equal ref_a.b.a.$ref, '1'
assert.equal ref_a.b.b.$ref, '2'

deref_a = ref.deref ref_a
assert.equal deref_a, deref_a.a
assert.equal deref_a, deref_a.b.a
assert.equal deref_a.b, deref_a.b.b

a = []
a.push a

ref_a = ref.ref a
assert.equal ref_a.$id, '1'
assert.equal ref_a.$values[0].$ref, '1'

deref_a = ref.deref a
assert.equal deref_a, deref_a[0]
