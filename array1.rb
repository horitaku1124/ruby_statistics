# -*- encoding: utf-8 -*-

require './MyArray'
a = [1,2,3,4,5]

p a

p a.sum
p a.mean
p a.devsq
p a.var
p a.varp
p a.stdev
p a.stdevp

a2 = [1.5, 2, 2.5, 3, 4]
print "covarOf=", a.covarOf(a2), "\n"
print "correlOf=", a.correlOf(a2), "\n"