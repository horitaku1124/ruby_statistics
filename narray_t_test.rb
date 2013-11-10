# -*- encoding: utf-8 -*-
#
# データはこちらから拝借
# http://kogolab.chillout.jp/elearn/hamburger/chap1/sec1.html
#

require 'narray'

def getT(percent, num)
	few95 = [12.706,4.303,3.182,2.776,2.571,2.447,2.365,2.306,2.262,2.226,2.201,2.179,2.16,2.145,2.131,2.12,2.11,2.101,2.093,2.086,2.08,2.074,2.069,2.064,2.06,2.056,2.052,2.048,2.045,2.042]
	
	few99 = [63.657,9.925,5.841,4.604,4.032,3.707,3.499,3.355,3.25,3.169,3.106,3.055,3.021,2.977,2.947,2.921,2.898,2.878,2.861,2.845,2.831,2.819,2.807,2.797,2.787,2.779,2.771,2.763,2.756,2.75]

	if percent == 95
		if num > 0 && num <= 30
			few95[num - 1]
		elsif num > 30 && num < 40
			2.021
		elsif num > 40 && num < 60
			2.000
		elsif num > 60 && num < 120
			1.980
		else
			1.960
		end
	elsif percent == 99
                if num > 0 && num <= 30
                        few99[num - 1]
                elsif num > 30 && num < 40
                        2.704
                elsif num > 40 && num < 60
                        2.660
                elsif num > 60 && num < 120
                        2.617
                else
                        2.576
                end
	else
		raise "error #{percent}"
	end
end


if ARGV.length == 0
	exit(1)
end

file = ARGV[0]
list = []
f = open(file)
f.each do |l|
	list << l.to_f
end
f.close

na = NArray.to_na(list)
mean = na.mean

print "相加平均=",mean,"\n"
print "標準偏差=",na.stddev,"\n"
stdev = 0.0
list.each do |n|
	stdev += (n - mean) ** 2
end

stdev = stdev / (list.length - 1)
print "不偏分散=",stdev,"\n"

mod = Math.sqrt(stdev / list.length)
print "標本標準誤差=",mod,"\n"
t = getT(95, list.length)
print "信頼区間(95%)\n"
print "  t=#{t} ", (mean-mod*t),"~", (mean+mod*t),"\n"

t = getT(99, list.length)
print "信頼区間(99%)\n"
print "  t=#{t} ", (mean-mod*t),"~", (mean+mod*t),"\n"
