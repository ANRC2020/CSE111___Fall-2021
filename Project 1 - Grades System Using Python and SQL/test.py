import time
from random import randint, randrange

f = open('students_names.txt', "r")
nf = open('Student.txt', 'w')

id = 1000
i = 1

for line in f:

    phone = [str(randint(1, 9)),str(randint(0, 9)),str(randint(0, 9)),'-',
    str(randint(0, 9)),str(randint(0, 9)),str(randint(0, 9)),'-',
    str(randint(0, 9)),str(randint(0, 9)),str(randint(0, 9)),str(randint(0, 9))]

    num = ''

    for j in range(len(phone)):
        num += phone[j]

    birthday = ""

    year = randint(1999, 2004)

    month = randint(1,12)

    if month < 10:
        month = "0" + str(month)
    else:
        month = str(month)

    day = randint(1,30)

    if day < 10:
        day = "0" + str(day)
    else:
        day = str(day)

    birth_day = [str(year),'-',month,
    '-',day]

    for j in range(len(birth_day)):
        birthday += birth_day[j]
    
    level = 0

    if(year == 1999):

        level = 4

    elif(year == 2001):

        x = randint(1,2)

        if(x == 1):
            level = 3
        if(x == 2):
            level = 4

    elif(year == 2002):

        x = randint(1,2)

        if(x == 1):
            level = 2
        if(x == 2):
            level = 3

    elif(year == 2003):
        
        x = randint(1,2)

        if(x == 1):
            level = 1
        if(x == 2):
            level = 2

    else:
        level = 1

    password = "" 
    
    for j in range(randrange(8,15)):

        x = 0

        while(True):
            x = randrange(33,122)

            if(x == 34 or (x >= 36 and x <=47) or (x >= 58 and x <= 63) or (x >= 91 and x <= 96)):
                continue
                
            break

        password += chr(x)

    nf.write(f"{id + i}|{line[0:len(line)-1]}|{num}|{birthday}|{password}|{level}\n")
    i += 1

nf.close() 
f.close()

#----------------------------------------------------

f = open('instructor_names.txt', "r")
nf = open('Instructor.txt', 'w')

id = 9000
k = 1

class_type = ['MATH', 'PHYS', 'CSE', 'PSYCH', 'WRI', 'SPANISH', 'ENGLISH', 
    'JAPANESE', 'ENGR', 'COGS', 'HIST', 'ART', 'CHEM', 'BIO']
course_count = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

for line in f:

    comment = []

    while(True):

        i = 0
        lim = randrange(1,2)
        courses = []

        while i <= lim:

            x = randrange(0,14)

            if(course_count[x] < 10):
                
                new = True

                for j in range(len(courses)):
                
                    if x == courses[j]:
                        new = False
                        break

                if(new == True):  

                    if(i < lim - 1):
                        comment.append(class_type[x])

                        course_count[x] += 1
                        courses.append(x)

                    else:
                        comment.append(class_type[x])

                        course_count[x] += 1 
                        courses.append(x)
                
                else:

                    continue
            
            i += 1

        break

    password = "" 
    
    for j in range(randrange(8,15)):

        x = 0

        while(True):
            x = randrange(33,122)

            if(x == 34 or (x >= 36 and x <=47) or (x >= 58 and x <= 63) or (x >= 91 and x <= 96)):
                continue
                
            break

        password += chr(x)

    instr_comment = ''

    if(len(comment) == 0):
        nf.write(f"{id + k}|{line[0:len(line)-1]}|{'None'}|{password}\n")
    elif(len(comment) == 1):
        nf.write(f"{id + k}|{line[0:len(line)-1]}|{comment[0]}|{password}\n")
    elif(len(comment) == 2):
        nf.write(f"{id + k}|{line[0:len(line)-1]}|{comment[0]},{comment[1]}|{password}\n")
    
    k += 1

print(course_count)

nf.close() 
f.close()

#-------------------------------------------------

nf = open('Classes.txt', 'w')

id = 100
c = 1

class_type = ['MATH', 'PHYS', 'CSE', 'PSYCH', 'WRI', 'SPANISH', 'ENGLISH', 
    'JAPANESE', 'ENGR', 'COGS', 'HIST', 'ART', 'CHEM', 'BIO']

for sub in class_type:

    for i in range(len(course_count)):

        c = 1

        for j in range(course_count[i]):
            
            nf.write(f"{id * c + j}|{str(sub + '-' + str(id * c + j))}|{num}|{birthday}|{password}|{level}\n")

        
nf.close() 
f.close()