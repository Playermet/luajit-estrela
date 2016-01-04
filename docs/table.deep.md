## Module table.deep
#### Preparation
Require module for start using it.
```lua
local deep = require 'est.table.deep'
```
This module use NaN for code to indicate lack of value.
```lua
local null = 0/0
```

#### deep.size(any) : number
Return count of all members, including nested.
```lua
local t = {1,2,3,{x=4,y=5},'foo'}
local s = deep.size(t)
-- s = 6
```

#### deep.copy(any) : any
Return deep copy of given value.
```lua
local a = {1,2,3,{x=4,y=5},'foo'}
local b = deep.copy(a)
-- b = {1,2,3,{x=4,y=5},'foo'}
```

#### deep.diff(any,any) : any
Return deep difference between two values;
```lua
local a = {1,2,3,{x=4},'foo'}
local b = {1,2,3,{y=6},'foo'}
local c = deep.diff(a,b)
-- c = {[4]={y=6,x=null}}

local r = deep.diff(5,6) -- r = 6
local r = deep.diff(5)   -- r = null
local r = deep.diff(5,5) -- r = nil
```

#### deep.apply(any,any) : any
Apply right argument to left, and return result;
```lua
local a = {1,2,3,{x=4},'foo'}
local b = {[4]={x=null,y=5}}
deep.apply(a,b)
-- a = {1,2,3,{y=5},"foo"}
```

#### deep.merge(any,any) : any
Merge two values into new one;
```lua
local a = {1,2,3,{x=4},'foo'}
local b = {[4]={x=0/0, y = 5}}
local c = deep.merge(a,b)
-- c = {1,2,3,{y=5},"foo"}
```

