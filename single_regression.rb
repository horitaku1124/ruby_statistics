# -*- encoding: utf-8 -*-

require './MyArray'

x = [10,4,2,2,8,9,7,5,1,3,4,6,8,11,6]
y = [10,5,5,4,4,6,6,2,1,2,7,7,9,8,4]

a = x.devmulOf(y) / x.devsq
a2 = x.covarOf(y) / y.varp
b = y.mean - a * x.mean
b2 = y.mean - a2 * x.mean

print "a=",a,"\n"
print "b=",b,"\n"

puts "近似直線"

puts "Y = #{a} X + #{b}"
puts "Y = #{a2}X + #{b2}"