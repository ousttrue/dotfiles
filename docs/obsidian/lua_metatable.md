
strings, numbers, nil, functions and lightuserdata have a single metatable for the whole type. tables and full userdata have a metatable for each instance.

from the docs:

> Tables and full userdata have individual metatables (although multiple tables and userdata can share their metatables). Values of all other types share one single metatable per type; that is, there is one single metatable for all numbers, one for all strings, etc.strings, etc.