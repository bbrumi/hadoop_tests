from random import randrange
from datetime import timedelta
from datetime import datetime

def random_date(start, end):
   """
   This function will return a random datetime between two datetime
   objects.
   """
   delta = end - start
   int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
   random_second = randrange(int_delta)
   return start + timedelta(seconds=random_second)

d1 = datetime.strptime('1/1/2008 1:30 PM', '%m/%d/%Y %I:%M %p')
d2 = datetime.strptime('1/1/2013 4:50 AM', '%m/%d/%Y %I:%M %p')

f = open('names.txt', 'r+')
f_out = open('birthdays.txt', 'w')

for line in f:
    line=line.rstrip('\n')
    f_out.write("%s|%s\n" % (line.strip(),random_date(d1, d2)))

f.close()
f_out.close()
